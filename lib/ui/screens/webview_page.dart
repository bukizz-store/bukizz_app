import 'package:bukizz/data/services/auth_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bukizz/data/providers/bottom_nav_bar_provider.dart';
import 'package:bukizz/ui/screens/Common/error_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final bool shouldInterceptCheckout;

  const WebViewPage({required this.url, this.title = '', this.shouldInterceptCheckout = false, Key? key})
      : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _isError = false;
  bool _canPop = false; // State to control PopScope
  bool _shouldReloadAfterTokenInjection = true; // Reload once after first token injection
  final AuthApiService _authApiService = AuthApiService();
  late Razorpay _razorpay;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..addJavaScriptChannel(
        'RazorpayChannel',
        onMessageReceived: (JavaScriptMessage message) {
          _handleRazorpayMessage(message);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              _isError = false;
              _canPop = false; // Reset to intercept back press again for history
            });
          },
          onPageFinished: (String url) {
            _injectTokens();
            setState(() {
              _isLoading = false;
            });
            setState(() {});
          },
          onWebResourceError: (WebResourceError error) {
            // Check if the error is for the main frame (ignoring sub-resources like images)
            // Use ?? false to handle nulls safely (assume not main frame if unknown to avoid blocking)
            if (error.isForMainFrame ?? false) {
              setState(() {
                _isError = true;
                _isLoading = false;
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (_handleCheckoutRedirect(request.url)) {
              return NavigationDecision.prevent;
            }
            if (_handleHomeRedirect(request.url)) {
              return NavigationDecision.prevent;
            }
            if (_handleProfileTabRedirect(request.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            _handleCheckoutRedirect(change.url ?? '');
            _handleHomeRedirect(change.url ?? '');
            _handleProfileTabRedirect(change.url ?? '');
          },
        ),
      );

    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
      (_controller.platform as AndroidWebViewController)
          .setGeolocationPermissionsPromptCallbacks(
        onShowPrompt: (GeolocationPermissionsRequestParams request) async {
          final LocationPermission permission = await Geolocator.requestPermission();
          return GeolocationPermissionsResponse(
            allow: permission == LocationPermission.whileInUse ||
                permission == LocationPermission.always,
            retain: false,
          );
        },
      );
      (_controller.platform as AndroidWebViewController)
          .setOnPlatformPermissionRequest((PlatformWebViewPermissionRequest request) {
        request.grant();
      });
    }

    _loadPage();
  }

  Future<void> _loadPage() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    await _controller.loadRequest(Uri.parse(widget.url));
  }

  Future<void> _reloadPage() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    await _controller.reload();
  }

  Future<void> _injectTokens() async {
    final accessToken = await _authApiService.getAccessToken();
    final refreshToken = await _authApiService.getRefreshToken();
    
    if (accessToken != null && refreshToken != null) {
      try {
        // Check if tokens are already synced to avoid unnecessary reload
        final Object? result = await _controller.runJavaScriptReturningResult("localStorage.getItem('access_token')");
        String? existingToken = result?.toString();
        // Remove quotes if present (e.g. '"token"')
        if (existingToken != null) {
          if (existingToken.startsWith('"') && existingToken.endsWith('"') && existingToken.length >= 2) {
            existingToken = existingToken.substring(1, existingToken.length - 1);
          }
          if (existingToken == "null") existingToken = null;
        }

        if (existingToken == accessToken) {
          print("Tokens already synced for ${widget.url}. Skipping reload.");
          return;
        }
      } catch (e) {
        print("Error checking existing tokens: $e");
        // Continue with injection if check fails
      }

      final script = '''
        localStorage.setItem('access_token', '$accessToken');
        localStorage.setItem('custom_token', '$accessToken'); 
        localStorage.setItem('refresh_token', '$refreshToken');
      ''';
      await _controller.runJavaScript(script);
      print("Tokens injected into WebView for ${widget.url}");
      
      // Reload to ensure the web app picks up the new auth state
      await _controller.reload();
      print("WebView reloaded after token injection");
      
    } else {
      // User is logged out, clear tokens from localStorage
      final script = '''
        localStorage.removeItem('access_token');
        localStorage.removeItem('custom_token');
        localStorage.removeItem('refresh_token');
      ''';
      await _controller.runJavaScript(script);
      print("Tokens cleared from WebView for ${widget.url}");
    }
  }

  bool _handleCheckoutRedirect(String url) {
    print(url);
    if (widget.shouldInterceptCheckout && (url.contains('/checkout') || url.contains('/cart'))) {
      print('WebViewPage: Intercepting checkou/cart URL: $url');
      if (mounted) {
        final bottomProvider =
            Provider.of<BottomNavigationBarProvider>(context, listen: false);
        if (bottomProvider.selectedIndex != 3) {
          bottomProvider.setSelectedIndex(3); // Switch to Cart tab
          return true;
        }
      }
    }
    return false;
  }

  bool _handleHomeRedirect(String url) {
    if (url.isEmpty) return false;
    final uri = Uri.parse(url);
    // Check if path is just '/' (ignoring query params if needed, or keeping strict)
    // Common web root might be "https://bukizz.in" (path empty) or "https://bukizz.in/" (path /)
    if (uri.path == '/' || uri.path.isEmpty) {
       print('WebViewPage: Intercepting home URL: $url');
       if (mounted) {
         final bottomProvider =
             Provider.of<BottomNavigationBarProvider>(context, listen: false);
         // If we are NOT on the home tab (index 0), switch to it.
         if (bottomProvider.selectedIndex != 0) {
           bottomProvider.setSelectedIndex(0); 
           return true;
         }
       }
    }
    return false;
  }

  bool _handleProfileTabRedirect(String url) {
    if (url.isEmpty) return false;
    final uri = Uri.parse(url);
    if (uri.path.contains('/profile-tab')) {
      print('WebViewPage: Intercepting profile-tab URL: $url');
      if (mounted) {
        Navigator.of(context).pop();
        return true;
      }
    }
    return false;
  }

  void _handleRazorpayMessage(JavaScriptMessage message) {
    try {
      final Map<String, dynamic> options = jsonDecode(message.message);
      // Ensure strict typing if needed, but open accepts Map<String, dynamic>
      _razorpay.open(options);
      print("Razorpay options opened: $options");
    } catch (e) {
      print("Error parsing Razorpay options: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final Map<String, dynamic> successResponse = {
      "razorpay_payment_id": response.paymentId,
      "razorpay_order_id": response.orderId,
      "razorpay_signature": response.signature
    };
    final jsonResponse = jsonEncode(successResponse);
    _controller.runJavaScript("window.onNativePaymentSuccess($jsonResponse)");
     print("Payment Success: $jsonResponse");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    final Map<String, dynamic> errorResponse = {
      "code": response.code,
      "description": response.message
    };
    final jsonResponse = jsonEncode(errorResponse);
    _controller.runJavaScript("window.onNativePaymentFailure($jsonResponse)");
    print("Payment Error: $jsonResponse");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet if needed
    print("External Wallet: ${response.walletName}");
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final navigator = Navigator.of(context);
        bool canGoBack = await _controller.canGoBack();
        
        print("WebViewPage: onPopInvoked. canGoBack: $canGoBack, navigator.canPop: ${navigator.canPop()}");

        if (canGoBack) {
          print("WebViewPage: Going back in WebView history");
          await _controller.goBack();
          return;
        }

        // If cannot go back in WebView:
        
        // 1. Check if we are pushed on a Navigator stack (e.g. from Search/ViewAll)
        if (navigator.canPop()) {
           setState(() {
            _canPop = true;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) navigator.pop();
          });
          return;
        }

        // 2. We are at the root of a Tab (MainScreen body)
        final bottomProvider = Provider.of<BottomNavigationBarProvider>(context, listen: false);
        
        // If not on Home tab, switch to Home
        if (bottomProvider.selectedIndex != 0) {
          bottomProvider.setSelectedIndex(0);
          return;
        }

        // If on Home tab, handle Double Back to Exit
        if (bottomProvider.selectedIndex == 0) {
           DateTime now = DateTime.now();
           if (currentBackPressTime == null || 
               now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
             currentBackPressTime = now;
             Fluttertoast.showToast(
               msg: "Press back again to exit",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
               backgroundColor: Colors.black54,
               textColor: Colors.white,
               fontSize: 16.0
             );
             return; 
           }
           SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: widget.title.isNotEmpty 
            ? AppBar(title: Text(widget.title), automaticallyImplyLeading: true) 
            : null,
        body: SafeArea(
          child: _isError 
            ? ErrorScreen(
                onRetry: _reloadPage,
                message: "We couldn't load the page. Please check your internet connection.",
              )
            : Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  // if (_isLoading)
                  //   const Center(child: CircularProgressIndicator()),
                ],
              ),
        ),
        floatingActionButton: !_isError // Hide back button on error screen, or keep it? Maybe keep standard back nav. 
          ? FutureBuilder<bool>(
              future: _controller.canGoBack(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () async {
                      if (await _controller.canGoBack()) {
                        await _controller.goBack();
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            )
          : null,
      ),
    );
  }
}
