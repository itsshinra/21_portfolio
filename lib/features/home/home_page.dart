import 'package:flutter/material.dart';
import 'package:flutter_portfolio/features/widgets/project_card.dart';
import 'package:flutter_portfolio/features/widgets/skill_chip.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  // Animation controllers and animations for the Header
  late AnimationController _headerAnimationController;
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;

  // Animation controllers and animations for About Me & Skills sections
  late AnimationController _aboutSkillsAnimationController;
  late Animation<Offset> _aboutMeSlideAnimation;
  late Animation<Offset> _skillsSlideAnimation;

  // Lists of animation controllers and animations for Project Cards
  final List<AnimationController> _projectAnimationControllers = [];
  final List<Animation<double>> _projectFadeAnimations = [];
  final List<Animation<double>> _projectScaleAnimations = [];

  @override
  void initState() {
    super.initState();

    // 1. Initialize Header Animations
    _headerAnimationController = AnimationController(
      vsync: this, // 'this' refers to the TickerProviderStateMixin
      duration: const Duration(milliseconds: 1000), // Duration of the animation
    );
    _headerFadeAnimation = CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeIn, // Animation curve for fading in
    );
    _headerSlideAnimation =
        Tween<Offset>(
          begin: const Offset(
            0,
            -0.2,
          ), // Starts slightly above its final position
          end: Offset.zero, // Ends at its normal position
        ).animate(
          CurvedAnimation(
            parent: _headerAnimationController,
            curve: Curves.easeOutCubic, // Animation curve for sliding
          ),
        );

    // 2. Initialize About Me & Skills Animations
    _aboutSkillsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _aboutMeSlideAnimation =
        Tween<Offset>(
          begin: const Offset(-0.5, 0), // Slides in from the left
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _aboutSkillsAnimationController,
            curve: Curves.easeOutBack, // A "bouncy" animation curve
          ),
        );
    _skillsSlideAnimation =
        Tween<Offset>(
          begin: const Offset(0.5, 0), // Slides in from the right
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _aboutSkillsAnimationController,
            curve: Curves.easeOutBack,
          ),
        );

    // 3. Initialize Project Cards Animations
    // We get the project data first to know how many controllers we need
    final int projectCount = _getProjectsData().length;
    for (int i = 0; i < projectCount; i++) {
      final controller = AnimationController(
        vsync: this,
        // Staggered delay: each card animates slightly after the previous one
        duration: Duration(milliseconds: 500 + i * 150),
      );
      _projectAnimationControllers.add(controller); // Store the controller
      _projectFadeAnimations.add(
        CurvedAnimation(parent: controller, curve: Curves.easeIn), // Fade in
      );
      _projectScaleAnimations.add(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutQuad,
        ), // Subtle scale
      );
    }

    // Start all animations after a short delay
    // This gives the UI a moment to render before animations begin, preventing a "flash"
    Future.delayed(const Duration(milliseconds: 300), () {
      _headerAnimationController.forward(); // Start header animation
      _aboutSkillsAnimationController
          .forward(); // Start About Me/Skills animation
      // Start each project card animation
      for (final controller in _projectAnimationControllers) {
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _aboutSkillsAnimationController.dispose();
    for (final controller in _projectAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Map<String, String>> _getProjectsData() {
    return [
      {
        'title': 'E-commerce Mobile App',
        'description':
            'Built a fully functional e-commerce app with user authentication, product listings, cart management, and payment integration.',
        'techStack': 'Flutter, Firebase, Provider, Stripe',
        'link':
            'https://github.com/itsshinra/E_Commerce',
        'image':
            'https://cdn.uistore.design/assets/images/e-comm-mobile-app-for-figma-thumb.webp',
      },
      {
        'title': '21Movie App',
        'description':
            'A streaming movie app that allow user to watch every movie, tv show and anime that they want endlessly.',
        'techStack': 'Flutter, REST API, BLoC, SQFlite',
        'link':
            'https://github.com/itsshinra/MNmovie_app',
        'image':
            'https://cdn.freebiesupply.com/images/large/1x/movies-database-mobile-app-k53.jpg', 
      },
      {
        'title': 'Task Management App',
        'description':
            'A simple and intuitive task management application with CRUD operations and user-friendly interface.',
        'techStack': 'Flutter, Hive, Provider',
        'link':
            'https://github.com/itsshinra/Hoobies_app',
        'image':
            'https://shaynakit.com/storage/assets/cover_project/WY0gOrCGwSJsxRhUF2jov3M9N1dAzulqNdszsLMd.png',
      },
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://i.pinimg.com/736x/a7/64/45/a7644524e486b6641d08c1639ea99a01.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context), 
                _buildAboutMe(context),
                _buildSkills(context), 
                _buildProjects(context),
                _buildContact(context), 
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Header Section Widget ---
  Widget _buildHeader(BuildContext context) {
    return SlideTransition(
      position: _headerSlideAnimation,
      child: FadeTransition(
        opacity: _headerFadeAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  'https://i.pinimg.com/736x/f2/a0/d9/f2a0d9d83e3da13b82f0b6018140e10c.jpg',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Voeurn Sovanmakara',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Flutter Developer | Mobile App Developer',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 15.0,
                runSpacing: 10.0,
                alignment: WrapAlignment.center,
                children: [
                  _buildSocialButton(
                    SvgPicture.asset('assets/svg/mail.svg'),
                    'mailto:voeurnsovanmakara313@gmail.com',
                  ),
                  _buildSocialButton(
                    SvgPicture.asset('assets/svg/linkedin.svg'),
                    'https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile',
                  ), // REPLACE
                  _buildSocialButton(
                    SvgPicture.asset('assets/svg/github.svg'),
                    'https://github.com/itsshinra',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Social Button Section Widget ---
  Widget _buildSocialButton(Widget icon, String url) {
    return AnimatedBuilder(
      animation: _headerAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_headerAnimationController.value * 0.05),
          child: IconButton(
            icon: icon,
            onPressed: () async {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                debugPrint('Could not launch $url');
              }
            },
          ),
        );
      },
    );
  }

  // --- About Me Section Widget ---
  Widget _buildAboutMe(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LiquidGlass(
        blur: 5,
        shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(15)),
        settings: const LiquidGlassSettings(
          thickness: 10,
          glassColor: Color.fromARGB(26, 138, 133, 133),
          lightIntensity: 1,
          blend: 40,
        ),
        child: SlideTransition(
          position: _aboutMeSlideAnimation, // Uses the slide animation
          child: FadeTransition(
            opacity: _aboutSkillsAnimationController, // Uses the fade animation
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(height: 20, thickness: 1, color: Colors.white),
                  const Text(
                    'Passionate Flutter developer with 3+ years of experience building cross-platform mobile applications. '
                    'I enjoy creating intuitive, performant, and beautiful user interfaces. '
                    'Always eager to learn new technologies and contribute to exciting projects.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Skills Section Widget ---
  Widget _buildSkills(BuildContext context) {
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
        shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(15)),
        settings: const LiquidGlassSettings(
          thickness: 10,
          glassColor: Color.fromARGB(26, 138, 133, 133),
          lightIntensity: 1,
          blend: 40,
        ),
        child: SlideTransition(
          position: _skillsSlideAnimation,
          child: FadeTransition(
            opacity: _aboutSkillsAnimationController, // Uses the fade animation
            child: Container(
              padding: const EdgeInsets.all(20.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Skills',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(height: 20, thickness: 1, color: Colors.white),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: skills
                        .map((skill) => SkillChip(skill: skill))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Projects Section Widget ---
  Widget _buildProjects(BuildContext context) {
    final List<Map<String, String>> projects = _getProjectsData();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LiquidGlass(
        blur: 5,
        shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(15)),
        settings: const LiquidGlassSettings(
          thickness: 10,
          glassColor: Color.fromARGB(26, 138, 133, 133),
          lightIntensity: 1,
          blend: 40,
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Projects',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Divider(height: 20, thickness: 1, color: Colors.white),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return ProjectCard(
                    title: project['title']!,
                    description: project['description']!,
                    techStack: project['techStack']!,
                    link: project['link']!,
                    imageUrl: project['image']!,
                    animation: _projectFadeAnimations[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Contact Section Widget ---
  Widget _buildContact(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LiquidGlass(
        blur: 5,
        shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(15)),
        settings: const LiquidGlassSettings(
          thickness: 10,
          glassColor: Color.fromARGB(26, 138, 133, 133),
          lightIntensity: 1,
          blend: 40,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Get In Touch',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'I am open to new opportunities and collaborations. Feel free to reach out!',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  const url =
                      'mailto:voeurnsovanmakara313@gmail.com?subject=Portfolio Inquiry';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    debugPrint('Could not launch email client.');
                  }
                },
                icon: const Icon(Icons.email, color: Colors.black),
                label: Text(
                  'Email Me',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
              const SizedBox(height: 30),
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

}
