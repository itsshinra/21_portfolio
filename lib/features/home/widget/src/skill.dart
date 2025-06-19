import 'package:flutter/material.dart';
import 'package:flutter_portfolio/features/widgets/skill_chip.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class SkillsSection extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final AnimationController animationController;

  const SkillsSection({
    super.key,
    required this.slideAnimation,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> skills = [
      'Flutter',
      'Dart',
      'Firebase',
      'REST APIs',
      'GitHub/GitLab',
      'PHP/Laravel',
      'SQFlite/Hive',
      'Agile Methodologies',
      'UI/UX Design Principles',
      'Native iOS/Android Basics',
      'State Management (Provider, BLoC)',
    ];

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
        child: SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: animationController,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(context),
                  const SizedBox(height: 20),
                  _buildSkillsGrid(skills),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        LiquidGlass(
          shape: const LiquidRoundedSuperellipse(
            borderRadius: Radius.circular(10),
          ),
          settings: const LiquidGlassSettings(thickness: 9),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.code, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Skills & Technologies',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsGrid(List<String> skills) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: skills.map((skill) => SkillChip(skill: skill)).toList(),
    );
  }
}
