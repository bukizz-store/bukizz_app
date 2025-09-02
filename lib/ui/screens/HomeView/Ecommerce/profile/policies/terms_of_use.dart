import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfUse extends StatelessWidget {
  static const String route = '/terms_of_use';
  const TermsOfUse({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms Of Use"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                "TERMS AND CONDITIONS",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Last Updated
              Text(
                "Last updated August 25, 2025",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 20),

              // Agreement Header
              const Text(
                "AGREEMENT TO OUR LEGAL TERMS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Company Intro
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  children: [
                    const TextSpan(text: "We are "),
                    const TextSpan(
                      text: "Bukizz Store",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text:
                          ' ("Company," "we," "us," "our"), a company registered in India at MOHAN VILA APARTMENT, Kanpur Nagar, Uttar Pradesh 208025.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Website & App Info
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  children: [
                    const TextSpan(text: "We operate the website "),
                    TextSpan(
                      text: "https://bukizz.com",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchUrl('https://bukizz.com'),
                    ),
                    const TextSpan(
                      text:
                          " (the \"Site\"), the mobile application Bukizz (the \"App\"), as well as any other related products and services that refer or link to these legal terms (the \"Legal Terms\") (collectively, the \"Services\").",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Business Description
              const Text(
                "Bukizz is a school amenities delivery platform that simplifies access to essential student needs like uniforms, books, and supplies, offering parents and students a convenient one-stop solution.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),

              // Contact Info
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  children: [
                    TextSpan(text: "You can contact us by phone at "),
                    TextSpan(
                      text: "(+91)9369467134",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ", email at "),
                    TextSpan(
                      text: "workspace@bukizz.in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ", or by mail to MOHAN VILA APARTMENT, Kanpur Nagar, Uttar Pradesh 208025, India.",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Table of Contents
              const Text(
                "TABLE OF CONTENTS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  "1. OUR SERVICES",
                  "2. INTELLECTUAL PROPERTY RIGHTS",
                  "3. USER REPRESENTATIONS",
                  "4. USER REGISTRATION",
                  "5. PRODUCTS",
                  "6. PURCHASES AND PAYMENT",
                  "7. RETURN POLICY",
                  "8. PROHIBITED ACTIVITIES",
                  "9. USER GENERATED CONTRIBUTIONS",
                  "10. CONTRIBUTION LICENSE",
                  "11. GUIDELINES FOR REVIEWS",
                  "12. MOBILE APPLICATION LICENSE",
                  "13. SERVICES MANAGEMENT",
                  "14. PRIVACY POLICY",
                  "15. TERM AND TERMINATION",
                  "16. MODIFICATIONS AND INTERRUPTIONS",
                  "17. GOVERNING LAW",
                  "18. DISPUTE RESOLUTION",
                  "19. CORRECTIONS",
                  "20. DISCLAIMER",
                  "21. LIMITATIONS OF LIABILITY",
                  "22. INDEMNIFICATION",
                  "23. USER DATA",
                  "24. ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES",
                  "25. MISCELLANEOUS",
                  "26. CONTACT US",
                ]
                    .map((text) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(text,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.5)),
                        ))
                    .toList(),
              ),

              const SizedBox(height: 20),

              // Our Services Section
              const Text(
                "1. OUR SERVICES",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "The information provided when using the Services is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country. Accordingly, those persons who choose to access the Services from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Intellectual Property Rights Section
              const Text(
                "2. INTELLECTUAL PROPERTY RIGHTS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Our intellectual property subsection
              const Text(
                "Our intellectual property",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "We are the owner or the licensee of all intellectual property rights in our Services, including all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics in the Services (collectively, the \"Content\"), as well as the trademarks, service marks, and logos contained therein (the \"Marks\").",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                "Our Content and Marks are protected by copyright and trademark laws (and various other intellectual property rights and unfair competition laws) and treaties around the world.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                "The Content and Marks are provided in or through the Services \"AS IS\" for your personal, non-commercial use only.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              // Your use of our Services subsection
              const SizedBox(height: 20),
              const Text(
                "Your use of our Services",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Subject to your compliance with these Legal Terms, including the \"PROHIBITED ACTIVITIES\" section below, we grant you a non-exclusive, non-transferable, revocable license to:",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("• access the Services; and",
                        style: TextStyle(fontSize: 14, color: Colors.black87)),
                    SizedBox(height: 4),
                    Text(
                        "• download or print a copy of any portion of the Content to which you have properly gained access",
                        style: TextStyle(fontSize: 14, color: Colors.black87)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "solely for your personal, non-commercial use.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                "Except as set out in this section or elsewhere in our Legal Terms, no part of the Services and no Content or Marks may be copied, reproduced, aggregated, republished, uploaded, posted, publicly displayed, encoded, translated, transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose whatsoever, without our express prior written permission.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  children: [
                    const TextSpan(
                      text:
                          "If you wish to make any use of the Services, Content, or Marks other than as set out in this section or elsewhere in our Legal Terms, please address your request to: ",
                    ),
                    TextSpan(
                      text: "workspace@bukizz.in",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                        text:
                            " If we ever grant you the permission to post, reproduce, or publicly display any part of our Services or Content, you must identify us as the owners or licensors of the Services, Content, or Marks and ensure that any copyright or proprietary notice appears or is visible on posting, reproducing, or displaying our Content."),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "We reserve all rights not expressly granted to you in and to the Services, Content, and Marks.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 12),
              const Text(
                "Any breach of these Intellectual Property Rights will constitute a material breach of our Legal Terms and your right to use our Services will terminate immediately.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              // Your submissions subsection
              const SizedBox(height: 20),
              const Text(
                "Your submissions",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please review this section and the \"PROHIBITED ACTIVITIES\" section carefully prior to using our Services to understand the (a) rights you give us and (b) obligations you have when you post or upload any content through the Services.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  children: [
                    TextSpan(
                      text: "Submissions: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          "By directly sending us any question, comment, suggestion, idea, feedback, or other information about the Services (\"Submissions\"), you agree to assign to us all intellectual property rights in such Submission. You agree that we shall own this Submission and be entitled to its unrestricted use and dissemination for any lawful purpose, commercial or otherwise, without acknowledgment or compensation to you.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  children: [
                    TextSpan(
                      text: "You are responsible for what you post or upload: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          "By sending us Submissions through any part of the Services you:",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                        "• confirm that you have read and agree with our \"PROHIBITED ACTIVITIES\" and will not post, send, publish, upload, or transmit through the Services any Submission that is illegal, harassing, hateful, harmful, defamatory, obscene, bullying, abusive, discriminatory, threatening to any person or group, sexually explicit, false, inaccurate, deceitful, or misleading;",
                        style: TextStyle(fontSize: 14, color: Colors.black87)),
                    SizedBox(height: 8),
                    Text(
                        "• to the extent permissible by applicable law, waive any and all moral rights to any such Submission;",
                        style: TextStyle(fontSize: 14, color: Colors.black87)),
                    SizedBox(height: 8),
                    Text(
                        "• warrant that any such Submission are original to you or that you have the necessary rights and licenses to submit such Submissions and that you have full authority to grant us the above-mentioned rights in relation to your Submissions; and",
                        style: TextStyle(fontSize: 14, color: Colors.black87)),
                    SizedBox(height: 8),
                    Text(
                        "• warrant and represent that your Submissions do not constitute confidential information.",
                        style: TextStyle(fontSize: 14, color: Colors.black87)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "You are solely responsible for your Submissions and you expressly agree to reimburse us for any and all losses that we may suffer because of your breach of (a) this section, (b) any third party's intellectual property rights, or (c) applicable law.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // User Representations Section
              const Text(
                "3. USER REPRESENTATIONS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("By using the Services, you represent and warrant that:",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  SizedBox(height: 8),
                  Text(
                      "• All registration information you submit will be true, accurate, current, and complete",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You will maintain the accuracy of such information and promptly update such registration information as necessary",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You have the legal capacity and you agree to comply with these Legal Terms",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You are not a minor in the jurisdiction in which you reside, or if a minor, you have received parental permission to use the Services",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You will not access the Services through automated or non-human means",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You will not use the Services for any illegal or unauthorized purpose",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Your use of the Services will not violate any applicable law or regulation",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                ]
                    .map((text) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: text,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              const Text(
                "If you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the Services (or any portion thereof).",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // User Registration Section
              const Text(
                "4. USER REGISTRATION",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "You may be required to register to use the Services. You agree to keep your password confidential and will be responsible for all use of your account and password. We reserve the right to remove, reclaim, or change a username you select if we determine, in our sole discretion, that such username is inappropriate, obscene, or otherwise objectionable.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Products Section
              const Text(
                "5. PRODUCTS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "We make every effort to display as accurately as possible the colors, features, specifications, and details of the products available on the Services. However, we do not guarantee that the colors, features, specifications, and details of the products will be accurate, complete, reliable, current, or free of other errors, and your electronic display may not accurately reflect the actual colors and details of the products. All products are subject to availability, and we cannot guarantee that items will be in stock. We reserve the right to discontinue any products at any time for any reason. Prices for all products are subject to change.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Purchases and Payment Section
              const Text(
                "6. PURCHASES AND PAYMENT",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "We accept the following forms of payment:",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                "• Cash on Delivery",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                "You agree to provide current, complete, and accurate purchase and account information for all purchases made via the Services. You further agree to promptly update account and payment information, including email address, payment method, and payment card expiration date, so that we can complete your transactions and contact you as needed. Sales tax will be added to the price of purchases as deemed required by us. We may change prices at any time. All payments shall be in US dollars.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                "You agree to pay all charges at the prices then in effect for your purchases and any applicable shipping fees, and you authorize us to charge your chosen payment provider for any such amounts upon placing your order. We reserve the right to correct any errors or mistakes in pricing, even if we have already requested or received payment.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                "We reserve the right to refuse any order placed through the Services. We may, in our sole discretion, limit or cancel quantities purchased per person, per household, or per order. These restrictions may include orders placed by or under the same customer account, the same payment method, and/or orders that use the same billing or shipping address. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers, or distributors.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Return Policy Section
              const Text(
                "7. RETURN POLICY",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "Please review our Return Policy posted on the Services prior to making any purchases.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Prohibited Activities Section
              const Text(
                "8. PROHIBITED ACTIVITIES",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "You may not access or use the Services for any purpose other than that for which we make the Services available. The Services may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                "As a user of the Services, you agree not to:",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                      "• Systematically retrieve data or other content from the Services to create or compile, directly or indirectly, a collection, compilation, database, or directory without written permission from us.",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Trick, defraud, or mislead us and other users, especially in any attempt to learn sensitive account information such as user passwords.",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Circumvent, disable, or otherwise interfere with security-related features of the Services, including features that prevent or restrict the use or copying of any Content or enforce limitations on the use of the Services and/or the Content contained therein.",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Disparage, tarnish, or otherwise harm, in our opinion, us and/or the Services.",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Use any information obtained from the Services in order to harass, abuse, or harm another person",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Make improper use of our support services or submit false reports of abuse or misconduct",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Use the Services in a manner inconsistent with any applicable laws or regulations",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Engage in unauthorized framing of or linking to the Services",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Upload or transmit (or attempt to upload or to transmit) viruses, Trojan horses, or other material, including excessive use of capital letters and spamming (continuous posting of repetitive text), that interferes with any party’s uninterrupted use and enjoyment of the Services or modifies, impairs, disrupts, alters, or interferes with the use, features, functions, operation, or maintenance of the Services.",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                ]
                    .map((text) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: text,
                        ))
                    .toList(),
              ),

              const SizedBox(height: 20),

              // User Generated Contributions Section
              const Text(
                "9. USER GENERATED CONTRIBUTIONS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "The Services does not offer users to submit or post content. We may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or on the Services, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, \"Contributions\"). Contributions may be viewable by other users of the Services and through third-party websites. When you create or make available any Contributions, you thereby represent and warrant that:",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Contribution License Section
              const Text(
                "10. CONTRIBUTION LICENSE",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "You and Services agree that we may access, store, process, and use any information and personal data that you provide following the terms of the Privacy Policy and your choices (including settings).",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                "By submitting suggestions or other feedback regarding the Services, you agree that we can use and share such feedback for any purpose without compensation to you.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                "We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area on the Services. You are solely responsible for your Contributions to the Services and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Guidelines for Reviews Section
              const Text(
                "11. GUIDELINES FOR REVIEWS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "We may provide you areas on the Services to leave reviews or ratings. When posting a review, you must comply with the following criteria:",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                      "• You should have firsthand experience with the person/entity being reviewed",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Your reviews should not contain offensive profanity, or abusive, racist, offensive, or hateful language",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Your reviews should not contain discriminatory references based on religion, race, gender, national origin, age, marital status, sexual orientation, or disability",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Your reviews should not contain references to illegal activity",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You should not be affiliated with competitors if posting negative reviews",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You should not make any conclusions as to the legality of conduct",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text("• You may not post any false or misleading statements",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You may not organize a campaign encouraging others to post reviews, whether positive or negative",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                ]
                    .map((text) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: text,
                        ))
                    .toList(),
              ),

              const SizedBox(height: 20),

              // Mobile Application License Section
              const Text(
                "12. MOBILE APPLICATION LICENSE",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Use License subsection
              const Text(
                "Use License",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "If you access the Services via the App, then we grant you a revocable, non-exclusive, non-transferable, limited right to install and use the App on wireless electronic devices owned or controlled by you, and to access and use the App on such devices strictly in accordance with the terms and conditions of this mobile application license contained in these Legal Terms. You shall not:",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                      "• Decompile, reverse engineer, disassemble, attempt to derive the source code of, or decrypt the App",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Make any modification, adaptation, improvement, enhancement, translation, or derivative work from the App",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Violate any applicable laws, rules, or regulations in connection with your access or use of the App",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Remove, alter, or obscure any proprietary notice of the App",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Use the App for any revenue generating endeavor or commercial enterprise",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Make the App available over a network or other environment permitting access by multiple devices or users",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Use the App to create a product, service, or software that competes with the App",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Use the App to send automated queries or unsolicited commercial email",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• Use proprietary information or interfaces of the App in the design, development, manufacture, licensing, or distribution of any applications, accessories, or devices",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                ]
                    .map((text) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: text,
                        ))
                    .toList(),
              ),

              // Apple and Android Devices subsection
              const SizedBox(height: 20),
              const Text(
                "Apple and Android Devices",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "The following terms apply when you use the App obtained from either the Apple Store or Google Play (each an \"App Distributor\"):",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                      "• The license granted is limited to a non-transferable license to use the App on a device that utilizes the Apple iOS or Android operating systems",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• We are responsible for providing maintenance and support services for the App",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• App Distributors have no warranty obligation whatsoever with respect to the App",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You represent that you are not located in a country subject to a U.S. Government embargo",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• You must comply with applicable third-party terms when using the App",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Text(
                      "• App Distributors are third-party beneficiaries of these Legal Terms",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                ]
                    .map((text) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: text,
                        ))
                    .toList(),
              ),

              const SizedBox(height: 20),

              // Services Management Section
              const Text(
                "13. SERVICES MANAGEMENT",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "We reserve the right, but not the obligation, to: (1) monitor the Services for violations of these Legal Terms; (2) take appropriate legal action against anyone who, in our sole discretion, violates the law or these Legal Terms; (3) refuse, restrict access to, limit the availability of, or disable any of your Contributions or any portion thereof; (4) remove from the Services or otherwise disable all files and content that are excessive in size or are in any way burdensome to our systems; and (5) otherwise manage the Services in a manner designed to protect our rights and property and to facilitate the proper functioning of the Services.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Privacy Policy Section
              const Text(
                "14. PRIVACY POLICY",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  children: [
                    const TextSpan(
                        text:
                            "We care about data privacy and security. Please review our Privacy Policy: "),
                    TextSpan(
                      text: "https://bukizz.com/privacy",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => _launchUrl('https://bukizz.com/privacy'),
                    ),
                    const TextSpan(
                        text:
                            ". By using the Services, you agree to be bound by our Privacy Policy, which is incorporated into these Legal Terms. Please be advised the Services are hosted in India. If you access the Services from any other region of the world with laws or other requirements governing personal data collection, use, or disclosure that differ from applicable laws in India, then through your continued use of the Services, you are transferring your data to India, and you expressly consent to have your data transferred to and processed in India."),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Term and Termination Section
              const Text(
                "15. TERM AND TERMINATION",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "These Legal Terms shall remain in full force and effect while you use the Services. WITHOUT LIMITING ANY OTHER PROVISION OF THESE LEGAL TERMS, WE RESERVE THE RIGHT TO, IN OUR SOLE DISCRETION AND WITHOUT NOTICE OR LIABILITY, DENY ACCESS TO AND USE OF THE SERVICES (INCLUDING BLOCKING CERTAIN IP ADDRESSES), TO ANY PERSON FOR ANY REASON OR FOR NO REASON, INCLUDING WITHOUT LIMITATION FOR BREACH OF ANY REPRESENTATION, WARRANTY, OR COVENANT CONTAINED IN THESE LEGAL TERMS OR OF ANY APPLICABLE LAW OR REGULATION. WE MAY TERMINATE YOUR USE OR PARTICIPATION IN THE SERVICES OR DELETE YOUR ACCOUNT AND ANY CONTENT OR INFORMATION THAT YOU POSTED AT ANY TIME, WITHOUT WARNING, IN OUR SOLE DISCRETION.",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // Modifications and Interruptions Section
              const Text(
                "16. MODIFICATIONS AND INTERRUPTIONS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "We reserve the right to change, modify, or remove the contents of the Services at any time or for any reason at our sole discretion without notice. We also reserve the right to modify or discontinue all or part of the Services without notice at any time. We will not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the Services.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Governing Law Section
              const Text(
                "17. GOVERNING LAW",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "These Legal Terms shall be governed by and defined following the laws of India. Bukizz Store and yourself irrevocably consent that the courts of India shall have exclusive jurisdiction to resolve any dispute which may arise in connection with these Legal Terms.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Contact Us Section
              const Text(
                "26. CONTACT US",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "In order to resolve a complaint regarding the Services or to receive further information regarding use of the Services, please contact us at:",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Bukizz Store",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "MOHAN VILA APARTMENT",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    "Kanpur Nagar, Uttar Pradesh 208025",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    "India",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    "Phone: (+91)9369467134",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    "Email: workspace@bukizz.in",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
