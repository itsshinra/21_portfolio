import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  

  Future<void> _handleEmailPress() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LiquidGlass(
        blur: 5,
        shape: const LiquidRoundedSuperellipse(
          borderRadius: Radius.circular(20),
        ),
        settings: const LiquidGlassSettings(
          thickness: 12,
          glassColor: Color.fromARGB(40, 153, 148, 148),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LiquidGlass(
                shape: const LiquidRoundedSuperellipse(
                  borderRadius: Radius.circular(15),
                ),
                settings: const LiquidGlassSettings(thickness: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.email, color: Colors.white, size: 32),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Get In Touch',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'I am open to new opportunities and collaborations.\nFeel free to reach out!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              _buildEmailButton(context),
              const SizedBox(height: 32),
              Text(
                '© 2025 Voeurn Sovanmakara. All rights reserved.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailButton(BuildContext context) {
    return LiquidGlass(
      shape: const LiquidRoundedSuperellipse(borderRadius: Radius.circular(30)),
      settings: const LiquidGlassSettings(thickness: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
          onPressed: _handleEmailPress,
          icon: const Icon(Icons.email, color: Colors.black),
          label: Text(
            'Email Me',
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
      ),
    );
  }

  
}
