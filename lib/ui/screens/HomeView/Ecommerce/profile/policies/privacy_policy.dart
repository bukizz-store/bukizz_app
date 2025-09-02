import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatefulWidget {
  static const String route = '/privacy_policy';
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(String sectionKey) {
    final context = this.context;
    final RenderObject? renderObject = sectionKey == 'infocollect'
        ? infocollectKey.currentContext?.findRenderObject()
        : sectionKey == 'infouse'
            ? infouseKey.currentContext?.findRenderObject()
            : sectionKey == 'whoshare'
                ? whoshareKey.currentContext?.findRenderObject()
                : sectionKey == 'cookies'
                    ? cookiesKey.currentContext?.findRenderObject()
                    : null;

    if (renderObject != null) {
      Scrollable.ensureVisible(
        sectionKey == 'infocollect'
            ? infocollectKey.currentContext!
            : sectionKey == 'infouse'
                ? infouseKey.currentContext!
                : sectionKey == 'whoshare'
                    ? whoshareKey.currentContext!
                    : cookiesKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Global keys for sections
  final GlobalKey infocollectKey = GlobalKey();
  final GlobalKey infouseKey = GlobalKey();
  final GlobalKey whoshareKey = GlobalKey();
  final GlobalKey cookiesKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'PRIVACY POLICY',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Main heading color
                ),
              ),
              const SizedBox(height: 12),

              // Last updated date
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575), // Grey text
                  ),
                  children: [
                    TextSpan(
                      text: 'Last updated ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'August 25, 2025'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Introduction
              const Text(
                'This Privacy Notice for Bukizz Store ("we," "us," or "our"), describes how and why we might access, collect, store, use, and/or share ("process") your personal information when you use our services ("Services"), including when you:',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const SizedBox(height: 12),

              // Bullet points
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 14)),
                      Expanded(
                        child: Wrap(
                          children: [
                            InkWell(
                              onTap: () => _launchUrl('https://bukizz.com'),
                              child: const Text(
                                'Visit our website at https://bukizz.com or any website of ours that links to this Privacy Notice',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: 14)),
                      Expanded(
                        child: Text(
                          'Download and use our mobile application (Bukizz), or any other application of ours that links to this Privacy Notice',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575)), // Grey for normal text
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: 14)),
                      Expanded(
                        child: Text(
                          'Engage with us in other related ways, including any sales, marketing, or events',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575)), // Grey for normal text
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Questions section
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575), // Grey for normal text
                  ),
                  children: [
                    TextSpan(
                      text: 'Questions or concerns? ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Reading this Privacy Notice will help you understand your privacy rights and choices.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'If you do not agree with our policies and practices, please do not use our Services. If you still have any questions or concerns, please contact us at bukizzstore@gmail.com.',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575)), // Grey for normal text
              ),
              const SizedBox(height: 20),

              // Summary section
              const Text(
                'SUMMARY OF KEY POINTS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242), // Darker grey for subheadings
                ),
              ),
              const SizedBox(height: 12),

              // Table of Contents
              const Text(
                'TABLE OF CONTENTS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242), // Darker grey for subheadings
                ),
              ),
              const SizedBox(height: 12),

              // TOC Links
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => _scrollToSection('infocollect'),
                    child: const Text(
                      '1. WHAT INFORMATION DO WE COLLECT?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('infouse'),
                    child: const Text(
                      '2. HOW DO WE PROCESS YOUR INFORMATION?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('whoshare'),
                    child: const Text(
                      '3. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('cookies'),
                    child: const Text(
                      '4. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Section 1: What Information Do We Collect
              Container(
                key: infocollectKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. WHAT INFORMATION DO WE COLLECT?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Main heading color
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Personal information you disclose to us',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF616161), // Medium grey for h3
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'In Short:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                    ),
                    const Text(
                      'We collect personal information that you provide to us.',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Personal Information List
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'The personal information that we collect depends on the context of your interactions with us and the Services, the choices you make, and the products and features you use. The personal information we collect may include the following:',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575)), // Grey for normal text
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ', style: TextStyle(fontSize: 14)),
                            Expanded(
                              child: Text(
                                'names',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ', style: TextStyle(fontSize: 14)),
                            Expanded(
                              child: Text(
                                'phone numbers',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ', style: TextStyle(fontSize: 14)),
                            Expanded(
                              child: Text(
                                'email addresses',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ', style: TextStyle(fontSize: 14)),
                            Expanded(
                              child: Text(
                                'passwords',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ', style: TextStyle(fontSize: 14)),
                            Expanded(
                              child: Text(
                                'usernames',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 2: How Do We Process Your Information
              Container(
                key: infouseKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. HOW DO WE PROCESS YOUR INFORMATION?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Main heading color
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'In Short:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                    ),
                    const Text(
                      'We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent.',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Processing reasons list
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'We process your personal information for a variety of reasons, depending on how you interact with our Services, including:',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575)), // Grey for normal text
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ', style: TextStyle(fontSize: 14)),
                            Expanded(
                              child: Text(
                                'To facilitate account creation and authentication and otherwise manage user accounts',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Color(0xFF757575), // Grey for normal text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ', style: TextStyle(fontSize: 14)),
                            Expanded(
                              child: Text(
                                'To deliver and facilitate delivery of services to the user',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Color(0xFF757575), // Grey for normal text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 3: When and With Whom Do We Share
              Container(
                key: whoshareKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Main heading color
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'In Short:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                    ),
                    const Text(
                      'We may share information in specific situations described in this section and/or with specific third parties.',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'We may need to share your personal information in the following situations:',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ', style: TextStyle(fontSize: 14)),
                        Expanded(
                          child: Text(
                            'Business Transfers. We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Color(0xFF757575)), // Grey for normal text
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 4: Cookies and Tracking
              Container(
                key: cookiesKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '4. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Main heading color
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'In Short:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                    ),
                    const Text(
                      'We may use cookies and other tracking technologies to collect and store your information.',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'We may use cookies and similar tracking technologies (like web beacons and pixels) to gather information when you interact with our Services. Some online tracking technologies help us maintain the security of our Services and your account, prevent crashes, fix bugs, save your preferences, and assist with basic site functions.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'We also permit third parties and service providers to use online tracking technologies on our Services for analytics and advertising, including to help manage and display advertisements, to tailor advertisements to your interests, or to send abandoned shopping cart reminders (depending on your communication preferences).',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 5: How Long Do We Keep Your Information
              const Text(
                '5. HOW LONG DO WE KEEP YOUR INFORMATION?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Main heading color
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'In Short:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const Text(
                'We keep your information for as long as necessary to fulfill the purposes outlined in this Privacy Notice unless otherwise required by law.',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'We will only keep your personal information for as long as it is necessary for the purposes set out in this Privacy Notice, unless a longer retention period is required or permitted by law. No purpose in this notice will require us keeping your personal information for longer than the period of time in which users have an account with us.',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575)), // Grey for normal text
              ),
              const SizedBox(height: 20),

              // Section 6: How Do We Keep Your Information Safe
              const Text(
                '6. HOW DO WE KEEP YOUR INFORMATION SAFE?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Main heading color
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'In Short:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const Text(
                'We aim to protect your personal information through a system of organizational and technical security measures.',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'We have implemented appropriate and reasonable technical and organizational security measures designed to protect the security of any personal information we process. However, despite our safeguards and efforts to secure your information, no electronic transmission over the Internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or unauthorized third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information. Although we will do our best to protect your personal information, transmission of personal information to and from our Services is at your own risk.',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575)), // Grey for normal text
              ),
              const SizedBox(height: 20),

              // Section 7: What Are Your Privacy Rights
              const Text(
                '7. WHAT ARE YOUR PRIVACY RIGHTS?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Main heading color
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'In Short:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const Text(
                'You may review, change, or terminate your account at any time.',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575), // Grey for normal text
                  ),
                  children: [
                    TextSpan(
                      text:
                          'If you have questions or comments about your privacy rights, you may email us at ',
                    ),
                    TextSpan(
                      text: 'bukizzstore@gmail.com',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 8: Controls for Do-Not-Track Features
              const Text(
                '8. CONTROLS FOR DO-NOT-TRACK FEATURES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Main heading color
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track ("DNT") feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. At this stage, no uniform technology standard for recognizing and implementing DNT signals has been finalized. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online.',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575)), // Grey for normal text
              ),
              const SizedBox(height: 20),

              // Section 9: Do We Make Updates To This Notice
              const Text(
                '9. DO WE MAKE UPDATES TO THIS NOTICE?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Main heading color
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'In Short:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const Text(
                'Yes, we will update this notice as necessary to stay compliant with relevant laws.',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'We may update this Privacy Notice from time to time. The updated version will be indicated by an updated "Revised" date at the top of this Privacy Notice. If we make material changes to this Privacy Notice, we may notify you either by prominently posting a notice of such changes or by directly sending you a notification. We encourage you to review this Privacy Notice frequently to be informed of how we are protecting your information.',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575)), // Grey for normal text
              ),
              const SizedBox(height: 20),

              // Section 10: How Can You Contact Us About This Notice
              const Text(
                '10. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Main heading color
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'If you have questions or comments about this notice, you may email us at bukizzstore@gmail.com or contact us by post at:',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575)), // Grey for normal text
              ),
              const SizedBox(height: 12),
              const Text(
                'Bukizz Store\nMOHAN VILA APARTMENT\nGEETA NAGAR\nKanpur Nagar, Uttar Pradesh 208025\nIndia',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575)), // Grey for normal text
              ),
              const SizedBox(height: 20),

              // Section 11: How Can You Review, Update or Delete Data
              const Text(
                '11. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Main heading color
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Based on the applicable laws of your country, you may have the right to request access to the personal information we collect from you, details about how we have processed it, correct inaccuracies, or delete your personal information. You may also have the right to withdraw your consent to our processing of your personal information. These rights may be limited in some circumstances by applicable law.',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575)), // Grey for normal text
              ),
              const SizedBox(height: 12),
              Wrap(
                children: [
                  const Text(
                    'To request to review, update, or delete your personal information, please fill out and submit a ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575)), // Grey for normal text
                  ),
                  InkWell(
                    onTap: () => _launchUrl(
                        'https://app.termly.io/notify/820179db-0e97-45b3-aa3e-9472f6605fc0'),
                    child: const Text(
                      'data subject access request',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Text(
                    '.',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575)), // Grey for normal text
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
