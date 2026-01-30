import 'package:bukizz/data/services/auth_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bukizz/data/providers/bottom_nav_bar_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
  bool _canPop = false; // State to control PopScope
  final AuthApiService _authApiService = AuthApiService();
  late Razorpay _razorpay;

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
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            _injectTokens();
            setState(() {
              _isLoading = false;
            });
            // Force rebuild to update FloatingActionButton visibility
            setState(() {});
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (_handleCheckoutRedirect(request.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            _handleCheckoutRedirect(change.url ?? '');
          },
        ),
      );
    _loadPage();
  }

  Future<void> _loadPage() async {
    // Inject tokens before loading if possible, or right after.
    // For local storage injection to work, domain might need to be loaded first or at least initialized.
    // Strategy: Load the page, then inject tokens and reload if needed, 
    // OR inject via evaluateJavascript immediately if the page supports it.
    // Better: Run javascript on finish.
    
    // Actually, localStorage is domain specific. We must load the domain first.
    // But if we load the domain without tokens, user is logged out.
    // Common trick: Load a blank page or the actual page, inject tokens, then reload.
    // Or inject logic that sets token if present.

    await _controller.loadRequest(Uri.parse(widget.url));
  }

  Future<void> _injectTokens() async {
    final accessToken = await _authApiService.getAccessToken();
    final refreshToken = await _authApiService.getRefreshToken();
    
    if (accessToken != null && refreshToken != null) {
      final script = '''
        localStorage.setItem('access_token', '$accessToken');
        localStorage.setItem('custom_token', '$accessToken'); 
        localStorage.setItem('refresh_token', '$refreshToken');
      ''';
      await _controller.runJavaScript(script);
      print("Tokens injected into WebView for ${widget.url}");
      
      // Optionally reload if we were on a page that needs auth immediately but rendered as guest
      // reload only once? Logic can be tricky.
      // For now, assume React app will pick up changes or we might need to trigger a re-render.
      // If we just set localStorage, React might not react until reload.
      // Let's reload once if it's the first load?
      // Or just run window.location.reload() in JS?
      // _controller.reload(); 
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
    if (widget.shouldInterceptCheckout && url.contains('/checkout')) {
      print('WebViewPage: Intercepting checkout URL: $url');
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
        
        final canGoBack = await _controller.canGoBack();
        if (canGoBack) {
          await _controller.goBack();
        } else {
          // If cannot go back in WebView, allow popping the screen
          setState(() {
            _canPop = true;
          });
          // Wait for the state update to propagate
          Future.microtask(() {
             if (context.mounted) Navigator.of(context).pop();
          });
        }
      },
      child: Scaffold(
        appBar: widget.title.isNotEmpty 
            ? AppBar(title: Text(widget.title), automaticallyImplyLeading: false) 
            : null,
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
        floatingActionButton: FutureBuilder<bool>(
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
        ),
      ),
    );
  }
}
