import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isEmailLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LiquidGlass(
        blur: 8,
        shape: const LiquidRoundedSuperellipse(
          borderRadius: Radius.circular(20),
        ),
        settings: const LiquidGlassSettings(
          thickness: 12,
          glassColor: Color.fromARGB(40, 255, 255, 255),
          lightIntensity: 0.8,
          blend: 35,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildContactIcon(),
              const SizedBox(height: 16),
              _buildTitle(context),
              const SizedBox(height: 12),
              _buildDescription(context),
              const SizedBox(height: 24),
              _buildEmailButton(context),
              const SizedBox(height: 32),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(Icons.email, color: Colors.white, size: 32),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Get In Touch',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      'I am open to new opportunities and collaborations.\nFeel free to reach out!',
      textAlign: TextAlign.center,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: Colors.white70, height: 1.5),
    );
  }

  Widget _buildEmailButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFF5F5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: _isEmailLoading ? null : _handleEmailPress,
        icon: _isEmailLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : const Icon(Icons.email, color: Colors.black),
        label: Text(
          _isEmailLoading ? 'Opening...' : 'Email Me',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Text(
      '© 2025 Voeurn Sovanmakara. All rights reserved.',
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: Colors.white54),
    );
  }

  Future<void> _handleEmailPress() async {
    setState(() => _isEmailLoading = true);
    try {
      const url =
          'mailto:voeurnsovanmakara313@gmail.com?subject=Portfolio Inquiry';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not launch email client'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _isEmailLoading = false);
    }
  }
}
