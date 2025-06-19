import 'package:flutter/material.dart';
import 'package:flutter_portfolio/features/widgets/project_card.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class ProjectsSection extends StatelessWidget {


  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = _getProjectsData();

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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context),
              const SizedBox(height: 20),
              _buildProjectsList(projects),
            ],
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
            child: const Icon(Icons.work, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Featured Projects',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsList(List<Map<String, String>> projects) {
    return Column(
      children: projects.asMap().entries.map((entry) {
        final project = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ProjectCard(
            title: project['title']!,
            description: project['description']!,
            techStack: project['techStack']!,
            link: project['link']!,
            imageUrl: project['image']!,
          ),
        );
      }).toList(),
    );
  }


  List<Map<String, String>> _getProjectsData() {
    return [
      {
        'title': 'E-commerce Mobile App',
        'description':
            'Built a fully functional e-commerce app with user authentication, product listings, cart management, and payment integration.',
        'techStack': 'Flutter, Firebase, Provider, Stripe',
        'link': 'https://github.com/itsshinra/E_Commerce',
        'image':
            'https://cdn.uistore.design/assets/images/e-comm-mobile-app-for-figma-thumb.webp',
      },
      {
        'title': '21Movie App',
        'description':
            'A streaming movie app that allows users to watch movies, TV shows and anime endlessly with a beautiful interface.',
        'techStack': 'Flutter, REST API, BLoC, SQFlite',
        'link': 'https://github.com/itsshinra/MNmovie_app',
        'image':
            'https://cdn.freebiesupply.com/images/large/1x/movies-database-mobile-app-k53.jpg',
      },
      {
        'title': 'Task Management App',
        'description':
            'A simple and intuitive task management application with CRUD operations and user-friendly interface.',
        'techStack': 'Flutter, Hive, Provider',
        'link': 'https://github.com/itsshinra/Hoobies_app',
        'image':
            'https://shaynakit.com/storage/assets/cover_project/WY0gOrCGwSJsxRhUF2jov3M9N1dAzulqNdszsLMd.png',
      },
    ];
  }
}
