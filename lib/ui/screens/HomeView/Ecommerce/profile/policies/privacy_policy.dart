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

  // Global keys for all sections
  final GlobalKey infocollectKey = GlobalKey();
  final GlobalKey infouseKey = GlobalKey();
  final GlobalKey whoshareKey = GlobalKey();
  final GlobalKey cookiesKey = GlobalKey();
  final GlobalKey retainKey = GlobalKey();
  final GlobalKey infoSafeKey = GlobalKey();
  final GlobalKey privacyRightsKey = GlobalKey();
  final GlobalKey doNotTrackKey = GlobalKey();
  final GlobalKey updatesKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  final GlobalKey reviewKey = GlobalKey();

  void _scrollToSection(String sectionKey) {
    GlobalKey? targetKey;

    switch (sectionKey) {
      case 'infocollect':
        targetKey = infocollectKey;
        break;
      case 'infouse':
        targetKey = infouseKey;
        break;
      case 'whoshare':
        targetKey = whoshareKey;
        break;
      case 'cookies':
        targetKey = cookiesKey;
        break;
      case 'retain':
        targetKey = retainKey;
        break;
      case 'infosafe':
        targetKey = infoSafeKey;
        break;
      case 'privacyrights':
        targetKey = privacyRightsKey;
        break;
      case 'donottrack':
        targetKey = doNotTrackKey;
        break;
      case 'updates':
        targetKey = updatesKey;
        break;
      case 'contact':
        targetKey = contactKey;
        break;
      case 'review':
        targetKey = reviewKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

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

              const Text(
                'This summary provides key points from our Privacy Notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575), // Grey for normal text
                ),
              ),
              const SizedBox(height: 12),

              // Key points list
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                      children: [
                        TextSpan(
                          text: 'What personal information do we process? ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'When you visit, use, or navigate our Services, we may process personal information depending on how you interact with us and the Services, the choices you make, and the products and features you use. Learn more about ',
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _scrollToSection('infocollect'),
                    child: const Text(
                      'what information we collect',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
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
                              'Do we process any sensitive personal information? ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'Some of the information may be considered "special" or "sensitive" in certain jurisdictions, for example your racial or ethnic origins, sexual orientation, and religious beliefs. We do not process sensitive personal information.',
                        ),
                      ],
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
                              'Do we collect any information from third parties? ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'We do not collect any information from third parties.',
                        ),
                      ],
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
                          text: 'How do we process your information? ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent. We process your information only when we have a valid legal reason to do so. Learn more about ',
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _scrollToSection('infouse'),
                    child: const Text(
                      'how we process your information',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
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
                              'In what situations and with which parties do we share personal information? ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'We may share information in specific situations and with specific third parties. Learn more about ',
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _scrollToSection('whoshare'),
                    child: const Text(
                      'when and with whom we share your personal information',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
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
                          text: 'How do we keep your information safe? ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'We aim to protect your personal information through a system of organizational and technical security measures. However, we cannot guarantee the security of any information you transmit to us or store on the Services, and you do so at your own risk. Learn more about ',
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    //how we keep your information safe.
                    onTap: () => _scrollToSection('infosafe'),
                    child: const Text(
                      'how we keep your information safe',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
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
                          text: 'What are your privacy rights? ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'Depending on where you are located geographically, the applicable privacy law may mean you have certain rights regarding your personal information. Learn more about',
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () => _scrollToSection('privacyrights'),
                    child: const Text(
                      'your privacy rights',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
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
                          text: 'How do you exercise your rights? ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        //The easiest way to exercise your rights is by submitting a data subject access request, or by contacting us. We will consider and act upon any request in accordance with applicable data protection laws.
                        TextSpan(
                          text:
                              'The easiest way to exercise your rights is by contacting us with a data subject access request. We will review and act on your request in accordance with applicable data protection laws. You can also manage your personal information directly within the app: ',
                        ),
                      ],
                    ),
                  ),
                  // send over a link to new webpage using a url
                  InkWell(
                    onTap: () => _scrollToSection('review'),
                    child: const Text(
                      ' HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU? ',
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
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('retain'),
                    child: const Text(
                      '5. HOW LONG DO WE KEEP YOUR INFORMATION?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('infosafe'),
                    child: const Text(
                      '6. HOW DO WE KEEP YOUR INFORMATION SAFE?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('privacyrights'),
                    child: const Text(
                      '7. WHAT ARE YOUR PRIVACY RIGHTS?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('donottrack'),
                    child: const Text(
                      '8. CONTROLS FOR DO-NOT-TRACK FEATURES',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('updates'),
                    child: const Text(
                      '9. DO WE MAKE UPDATES TO THIS NOTICE?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('contact'),
                    child: const Text(
                      '10. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _scrollToSection('review'),
                    child: const Text(
                      '11. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?',
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
                      children: [
                        const Text(
                          'The personal information that we collect depends on the context of your interactions with us and the Services, the choices you make, and the products and features you use. The personal information we collect may include the following:',
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
                                'names',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
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
                                'phone numbers',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
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
                                'email addresses',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
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
                                'passwords',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
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
                                'usernames',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Sensitive Information. We do not process sensitive information.',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575)), // Grey for normal text
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Application Data. If you use our application(s), we also may collect the following information if you choose to provide us with access or permission:',
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
                                'Geolocation Information. We may request access or permission to track location-based information from your mobile device, either continuously or while you are using our mobile application(s), to provide certain location-based services. If you wish to change our access or permissions, you may do so in your device\'s settings.',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
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
                                'Mobile Device Data. We automatically collect device information (such as your mobile device ID, model, and manufacturer), operating system, version information and system configuration information, device and application identification numbers, browser type and version, hardware model Internet service provider and/or mobile carrier, and Internet Protocol (IP) address (or proxy server). If you are using our application(s), we may also collect information about the phone network associated with your mobile device, your mobile device\'s operating system or platform, the type of mobile device you use, your mobile device\'s unique device ID, and information about the features of our application(s) you accessed.',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
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
                                'Push Notifications. We may request to send you push notifications regarding your account or certain features of the application(s). If you wish to opt out from receiving these types of communications, you may turn them off in your device\'s settings.',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'This information is primarily needed to maintain the security and operation of our application(s), for troubleshooting, and for our internal analytics and reporting purposes.',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575)), // Grey for normal text
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'All personal information that you provide to us must be true, complete, and accurate, and you must notify us of any changes to such personal information.',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575)), // Grey for normal text
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Google API',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF616161), // Medium grey for h3
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          children: [
                            const Text(
                              'Our use of information received from Google APIs will adhere to ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(
                                      0xFF757575)), // Grey for normal text
                            ),
                            InkWell(
                              onTap: () => _launchUrl(
                                  'https://developers.google.com/terms/api-services-user-data-policy'),
                              child: const Text(
                                'Google API Services User Data Policy',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const Text(
                              ', including the ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(
                                      0xFF757575)), // Grey for normal text
                            ),
                            InkWell(
                              onTap: () => _launchUrl(
                                  'https://developers.google.com/terms/api-services-user-data-policy#limited-use'),
                              child: const Text(
                                'Limited Use requirements',
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
                                  color: Color(
                                      0xFF757575)), // Grey for normal text
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
                    const Text(
                      'We process your personal information for a variety of reasons, depending on how you interact with our Services, including:',
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
                            'To facilitate account creation and authentication and otherwise manage user accounts. We may process your information so you can create and log in to your account, as well as keep your account in working order.',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Color(0xFF757575)), // Grey for normal text
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
                            'To deliver and facilitate delivery of services to the user. We may process your information to provide you with the requested service.',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Color(0xFF757575)), // Grey for normal text
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
                            'To respond to user inquiries/offer support to users. We may process your information to respond to your inquiries and solve any potential issues you might have with the requested service.',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Color(0xFF757575)), // Grey for normal text
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
                            'To fulfill and manage your orders. We may process your information to fulfill and manage your orders, payments, returns, and exchanges made through the Services.',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Color(0xFF757575)), // Grey for normal text
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
                            'To request feedback. We may process your information when necessary to request feedback and to contact you about your use of our Services.',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Color(0xFF757575)), // Grey for normal text
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 14)),
                        Expanded(
                          child: Wrap(
                            children: [
                              const Text(
                                'To send you marketing and promotional communications. We may process the personal information you send to us for our marketing purposes, if this is in accordance with your marketing preferences. You can opt out of our marketing emails at any time. For more information, see "',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
                              ),
                              InkWell(
                                onTap: () => _scrollToSection('privacyrights'),
                                child: const Text(
                                  'WHAT ARE YOUR PRIVACY RIGHTS?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const Text(
                                '" below.',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        0xFF757575)), // Grey for normal text
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
                            'To evaluate and improve our Services, products, marketing, and your experience. We may process your information when we believe it is necessary to identify usage trends, determine the effectiveness of our promotional campaigns, and to evaluate and improve our Services, products, marketing, and your experience.',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Color(0xFF757575)), // Grey for normal text
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
                            'To identify usage trends. We may process information about how you use our Services to better understand how they are being used so we can improve them.',
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
                      'We also permit third parties and service providers to use online tracking technologies on our Services for analytics and advertising, including to help manage and display advertisements, to tailor advertisements to your interests, or to send abandoned shopping cart reminders (depending on your communication preferences). The third parties and service providers use their technology to provide advertising about products and services tailored to your interests which may appear either on our Services or on other websites.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Specific information about how we use such technologies and how you can refuse certain cookies is set out in our Cookie Notice.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 5: How Long Do We Keep Your Information
              Container(
                key: retainKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 12),
                    const Text(
                      'When we have no ongoing legitimate business need to process your personal information, we will either delete or anonymize such information, or, if this is not possible (for example, because your personal information has been stored in backup archives), then we will securely store your personal information and isolate it from any further processing until deletion is possible.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 6: How Do We Keep Your Information Safe
              Container(
                key: infoSafeKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      'We have implemented appropriate and reasonable technical and organizational security measures designed to protect the security of any personal information we process. However, despite our safeguards and efforts to secure your information, no electronic transmission over the Internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or unauthorized third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information. Although we will do our best to protect your personal information, transmission of personal information to and from our Services is at your own risk.You should only access the Services within a secure environment.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 7: What Are Your Privacy Rights
              Container(
                key: privacyRightsKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      'You may review, change, or terminate your account at any time, depending on your country, province, or state of residence.',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF757575), // Grey for normal text
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575), // Grey for normal text
                        ),
                        children: [
                          const TextSpan(
                            text:
                                'WITHDRAW YOUR CONSENT: If we are relying on your consent to process your personal information, which may be express and/or implied consent depending on the applicable law, you have the right to withdraw your consent at any time. You can withdraw your consent at any time by contacting us by using the contact details provided in the section "',
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () => _scrollToSection('contact'),
                              child: const Text(
                                'HOW CAN YOU CONTACT US ABOUT THIS NOTICE?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(
                            text: '" below.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'However, please note that this will not affect the lawfulness of the processing before its withdrawal nor, when applicable law allows, will it affect the processing of your personal information conducted in reliance on lawful processing grounds other than consent.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Account Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF616161), // Medium grey for h3
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'If you would at any time like to review or change the information in your account or terminate your account, you can:',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Log in to your account settings and update your user account.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Upon your request to terminate your account, we will deactivate or delete your account and information from our active databases. However, we may retain some information in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our legal terms and/or comply with applicable legal requirements.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Cookies and similar technologies: Most Web browsers are set to accept cookies by default. If you prefer, you can usually choose to set your browser to remove cookies and to reject cookies. If you choose to remove cookies or reject cookies, this could affect certain features or services of our Services.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
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
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 8: Controls for Do-Not-Track Features
              Container(
                key: doNotTrackKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      'Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track ("DNT") feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. At this stage, no uniform technology standard for recognizing and implementing DNT signals has been finalized. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online.If a standard for online tracking is adopted that we must follow in the future, we will inform you about that practice in a revised version of this Privacy Notice.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 9: Do We Make Updates To This Notice
              Container(
                key: updatesKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 10: How Can You Contact Us About This Notice
              Container(
                key: contactKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section 11: How Can You Review, Update or Delete Data
              Container(
                key: reviewKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const Text(
                      'You can manage your personal information directly within the app. You may:',
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
                            'Review or update your data by editing your profile details.',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Color(0xFF757575)), // Grey for normal text
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
                            'Delete your account at any time by going to Profile → Delete My Account.',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Color(0xFF757575)), // Grey for normal text
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Once you delete your account, your personal information will be removed from our active systems, except where retention is required by law.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575)), // Grey for normal text
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
