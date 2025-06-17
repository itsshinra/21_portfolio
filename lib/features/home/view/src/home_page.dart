import 'package:flutter/material.dart';
import 'package:flutter_portfolio/features/home/widget/widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _headerAnimationController;
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;

  late AnimationController _aboutSkillsAnimationController;
  late Animation<Offset> _aboutMeSlideAnimation;
  late Animation<Offset> _skillsSlideAnimation;

  final List<AnimationController> _projectAnimationControllers = [];
  final List<Animation<double>> _projectFadeAnimations = [];

  // Scroll controller and keys
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Header animations
    _headerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _headerFadeAnimation = CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeInOut,
    );
    _headerSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _headerAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    // About & Skills animations
    _aboutSkillsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _aboutMeSlideAnimation =
        Tween<Offset>(begin: const Offset(-0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _aboutSkillsAnimationController,
            curve: Curves.easeOutBack,
          ),
        );
    _skillsSlideAnimation =
        Tween<Offset>(begin: const Offset(0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _aboutSkillsAnimationController,
            curve: Curves.easeOutBack,
          ),
        );

    // Project animations
    for (int i = 0; i < 3; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600 + i * 200),
      );
      _projectAnimationControllers.add(controller);
      _projectFadeAnimations.add(
        CurvedAnimation(parent: controller, curve: Curves.easeIn),
      );
    }
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _headerAnimationController.forward();
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            _aboutSkillsAnimationController.forward();
            Future.delayed(const Duration(milliseconds: 300), () {
              for (final controller in _projectAnimationControllers) {
                if (mounted) controller.forward();
              }
            });
          }
        });
      }
    });
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _aboutSkillsAnimationController.dispose();
    _scrollController.dispose();
    for (final controller in _projectAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BackgroundWidget(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              HeaderSection(
                fadeAnimation: _headerFadeAnimation,
                slideAnimation: _headerSlideAnimation,
                animationController: _headerAnimationController,
              ),
              Container(
                key: _aboutKey,
                child: AboutMeSection(
                  slideAnimation: _aboutMeSlideAnimation,
                  animationController: _aboutSkillsAnimationController,
                ),
              ),
              Container(
                key: _skillsKey,
                child: SkillsSection(
                  slideAnimation: _skillsSlideAnimation,
                  animationController: _aboutSkillsAnimationController,
                ),
              ),
              Container(
                key: _projectsKey,
                child: ProjectsSection(
                  projectFadeAnimations: _projectFadeAnimations,
                ),
              ),
              Container(key: _contactKey, child: const ContactSection()),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: NavigationFAB(
        onAboutPressed: () => _scrollToSection(_aboutKey),
        onSkillsPressed: () => _scrollToSection(_skillsKey),
        onProjectsPressed: () => _scrollToSection(_projectsKey),
        onContactPressed: () => _scrollToSection(_contactKey),
      ),
    );
  }
}
