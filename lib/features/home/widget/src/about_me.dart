import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class AboutMeSection extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final AnimationController animationController;

  const AboutMeSection({
    super.key,
    required this.slideAnimation,
    required this.animationController,
  });

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
                  _buildDescription(),
                  const SizedBox(height: 16),
                  _buildStatsContainer(),
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
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          'About Me',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Passionate Flutter developer with 3+ years of experience building cross-platform mobile applications. '
      'I enjoy creating intuitive, performant, and beautiful user interfaces that provide exceptional user experiences. '
      'Always eager to learn new technologies and contribute to exciting projects that make a difference.',
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 16, height: 1.6, color: Colors.white),
    );
  }

  Widget _buildStatsContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('3+', 'Years Experience'),
          _buildStatItem('15+', 'Projects'),
          _buildStatItem('100%', 'Client Satisfaction'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
