import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

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
        LiquidGlass(
          blur: 5,
          shape: const LiquidRoundedSuperellipse(
            borderRadius: Radius.circular(15),
          ),
          settings: const LiquidGlassSettings(
            thickness: 12,
            glassColor: Color.fromARGB(40, 153, 148, 148),
          ),
          child: FloatingActionButton.small(
            heroTag: "about",
            onPressed: onAboutPressed,
            backgroundColor: Colors.transparent,
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        LiquidGlass(
          blur: 5,
          shape: const LiquidRoundedSuperellipse(
            borderRadius: Radius.circular(15),
          ),
          settings: const LiquidGlassSettings(
            thickness: 12,
            glassColor: Color.fromARGB(40, 153, 148, 148),
          ),
          child: FloatingActionButton.small(
            heroTag: "skills",
            onPressed: onSkillsPressed,
            backgroundColor: Colors.transparent,
            child: const Icon(Icons.code, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        LiquidGlass(
          blur: 5,
          shape: const LiquidRoundedSuperellipse(
            borderRadius: Radius.circular(15),
          ),
          settings: const LiquidGlassSettings(
            thickness: 12,
            glassColor: Color.fromARGB(40, 153, 148, 148),
          ),
          child: FloatingActionButton.small(
            heroTag: "projects",
            onPressed: onProjectsPressed,
            backgroundColor: Colors.transparent,
            child: const Icon(Icons.work, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        LiquidGlass(
          blur: 5,
          shape: const LiquidRoundedSuperellipse(
            borderRadius: Radius.circular(15),
          ),
          settings: const LiquidGlassSettings(
            thickness: 12,
            glassColor: Color.fromARGB(40, 153, 148, 148),
          ),
          child: FloatingActionButton.small(
            heroTag: "contact",
            onPressed: onContactPressed,
            backgroundColor: Colors.transparent,
            child: const Icon(Icons.email, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
