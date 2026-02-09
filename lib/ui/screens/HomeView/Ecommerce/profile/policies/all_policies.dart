import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AllPoliciesScreen extends StatelessWidget {
  static const String route = '/all_policies';
  const AllPoliciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policies'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildPolicyCard(
                  context,
                  'Privacy Policy',
                  'Learn how we handle your data',
                  Icons.privacy_tip_outlined,
                  () => _navigateToPolicy(context, 'privacy'),
                ),
                const SizedBox(height: 16),
                _buildPolicyCard(
                  context,
                  'Terms of Use',
                  'Rules for using our services',
                  Icons.description_outlined,
                  () => _navigateToPolicy(context, 'terms'),
                ),
                const SizedBox(height: 16),
                _buildPolicyCard(
                  context,
                  'Return Policy',
                  'Our product return guidelines',
                  Icons.assignment_return_outlined,
                  () => _navigateToPolicy(context, 'return'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    Dimensions dimensions = Dimensions(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: dimensions.width10 * 2.5,
                backgroundColor: Color(0xFFCCE8FF),
                child: Icon(
                  icon,
                  color: Color(0xFF0590FF),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPolicy(BuildContext context, String policyType) {
    // To be implemented with actual navigation
    switch (policyType) {
      case 'privacy':
        Navigator.pushNamed(context, '/privacy_policy');
        break;
      case 'terms':
        Navigator.pushNamed(context, '/terms_of_use');
        break;
      case 'return':
        Navigator.pushNamed(context, '/return_policy');
        break;
    }
  }
}
