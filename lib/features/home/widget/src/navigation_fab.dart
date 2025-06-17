import 'package:flutter/material.dart';

class NavigationFAB extends StatelessWidget {
  final VoidCallback onAboutPressed;
  final VoidCallback onSkillsPressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onContactPressed;

  const NavigationFAB({
    super.key,
    required this.onAboutPressed,
    required this.onSkillsPressed,
    required this.onProjectsPressed,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          heroTag: "about",
          onPressed: onAboutPressed,
          backgroundColor: Colors.white.withOpacity(0.9),
          child: const Icon(Icons.person, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        FloatingActionButton.small(
          heroTag: "skills",
          onPressed: onSkillsPressed,
          backgroundColor: Colors.white.withOpacity(0.9),
          child: const Icon(Icons.code, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        FloatingActionButton.small(
          heroTag: "projects",
          onPressed: onProjectsPressed,
          backgroundColor: Colors.white.withOpacity(0.9),
          child: const Icon(Icons.work, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        FloatingActionButton.small(
          heroTag: "contact",
          onPressed: onContactPressed,
          backgroundColor: Colors.white.withOpacity(0.9),
          child: const Icon(Icons.email, color: Colors.black87),
        ),
      ],
    );
  }
}
