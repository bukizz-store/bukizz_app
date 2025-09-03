import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ReturnPolicyPage extends StatelessWidget {
  static const String routeName = '/return_policy';
  const ReturnPolicyPage({Key? key}) : super(key: key);

  Future<void> _launchEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    const String fullText = '''RETURN POLICY

Last updated June 01, 2025

Thank you for your purchase. We hope you are happy with your purchase. However, if you are not completely satisfied with your purchase for any reason, you may return it to us for a refund or an exchange. Please see below for more information on our return policy.

RETURNS

All returns must be postmarked within three (3) days of the purchase date. All returned items must be in new and unused condition, with all original tags and labels attached.

RETURN PROCESS

To return an item, please email customer service at bukizzstore@gmail.com to obtain an Return Merchandise Authorization (RMA) number. After receiving an RMA number, place the item securely in its original packaging and include your proof of purchase, then mail your return to the following address:

The Companies Delivery Partner Will Pick up The Order
Attn: Returns
RMA #
__________
__________, __________

Please note, you will be responsible for all return shipping charges. We strongly recommend that you use a trackable method to mail your return.

REFUNDS

After receiving your return and inspecting the condition of your item, we will process your return or exchange. Please allow at least seven (7) days from the receipt of your item to process your return or exchange. We will notify you by email when your return has been processed.

EXCEPTIONS

The following items cannot be returned or exchanged:

• Damaged items are not returned
• Any Item applied for Return after 3 days of Delivery
• Accepting the return order for a correctly delivered item is entirely at the discretion of the company.
• Tangible or usable items such as clothes, pencils, stationery, etc.

For defective or damaged products, please contact us at the contact details below to arrange a refund or exchange.

Please Note

• Only wrong Order / Damaged Orders delivered will be entertained for Exchange
• No Order will be accepted for Exchange after 3 days of Delivery
• There is no provision for Refund in any case
• Refunds, if any, will be processed only at the sole discretion of the company.

QUESTIONS

If you have any questions concerning our return policy, please contact us at:

09369467134
bukizzstore@gmail.com''';

    await Clipboard.setData(const ClipboardData(text: fullText));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Full policy copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Policy"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => _copyToClipboard(context),
            icon: const Icon(Icons.copy),
            tooltip: 'Copy full policy',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const SelectableText(
                "RETURN POLICY",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Last updated
              const SelectableText(
                "Last updated June 01, 2025",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Introduction
              const SelectableText(
                "Thank you for your purchase. We hope you are happy with your purchase. However, if you are not completely satisfied with your purchase for any reason, you may return it to us for a refund or an exchange. Please see below for more information on our return policy.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // RETURNS Section
              const SelectableText(
                "RETURNS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              const SelectableText(
                "All returns must be postmarked within three (3) days of the purchase date. All returned items must be in new and unused condition, with all original tags and labels attached.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // RETURN PROCESS Section
              const SelectableText(
                "RETURN PROCESS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              SelectableText.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(text: "To return an item, please email customer service at "),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () => _launchEmail("bukizzstore@gmail.com"),
                        child: const Text(
                          "bukizzstore@gmail.com",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: " to obtain an Return Merchandise Authorization (RMA) number. After receiving an RMA number, place the item securely in its original packaging and include your proof of purchase, then mail your return to the following address:",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              const SelectableText(
                "The Companies Delivery Partner Will Pick up The Order",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SelectableText(
                "Attn: Returns",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SelectableText(
                "RMA #",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SelectableText(
                "__________",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SelectableText(
                "__________, __________",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),

              const SelectableText(
                "Please note, you will be responsible for all return shipping charges. We strongly recommend that you use a trackable method to mail your return.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // REFUNDS Section
              const SelectableText(
                "REFUNDS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              const SelectableText(
                "After receiving your return and inspecting the condition of your item, we will process your return or exchange. Please allow at least seven (7) days from the receipt of your item to process your return or exchange. We will notify you by email when your return has been processed.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // EXCEPTIONS Section
              const SelectableText(
                "EXCEPTIONS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              const SelectableText(
                "The following items cannot be returned or exchanged:",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),

              // Exception bullet points
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SelectableText(
                    "• Damaged items are not returned",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SelectableText(
                    "• Any Item applied for Return after 3 days of Delivery",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SelectableText(
                    "• Accepting the return order for a correctly delivered item is entirely at the discretion of the company.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SelectableText(
                    "• Tangible or usable items such as clothes, pencils, stationery, etc.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              const SelectableText(
                "For defective or damaged products, please contact us at the contact details below to arrange a refund or exchange.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // Please Note Section
              const SelectableText(
                "Please Note",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Additional bullet points
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SelectableText(
                    "• Only wrong Order / Damaged Orders delivered will be entertained for Exchange",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SelectableText(
                    "• No Order will be accepted for Exchange after 3 days of Delivery",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SelectableText(
                    "• There is no provision for Refund in any case",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SelectableText(
                    "• Refunds, if any, will be processed only at the sole discretion of the company.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // QUESTIONS Section
              const SelectableText(
                "QUESTIONS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              const SelectableText(
                "If you have any questions concerning our return policy, please contact us at:",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),

              // Contact Information
              InkWell(
                onTap: () => _launchPhone("09369467134"),
                child: const SelectableText(
                  "09369467134",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              InkWell(
                onTap: () => _launchEmail("bukizzstore@gmail.com"),
                child: const SelectableText(
                  "bukizzstore@gmail.com",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
