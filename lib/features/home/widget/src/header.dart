// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderSection extends StatefulWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final AnimationController animationController;

  const HeaderSection({
    super.key,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.animationController,
  });

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  bool _isSocialLoading = false;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.slideAnimation,
      child: FadeTransition(
        opacity: widget.fadeAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 33, 77, 97), Color.fromARGB(255, 15, 46, 73)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildProfilePicture(),
              const SizedBox(height: 24),
              _buildName(),
              const SizedBox(height: 8),
              _buildTitle(),
              const SizedBox(height: 24),
              _buildSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Hero(
      tag: 'profile_picture',
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 75,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 72,
            backgroundImage: const NetworkImage(
              'https://i.pinimg.com/736x/6f/a7/d6/6fa7d6c5651c5ed6cd2ae1f5ab835d2c.jpg',
            ),
            onBackgroundImageError: (exception, stackTrace) {
              debugPrint('Error loading profile image: $exception');
            },
            child: const SizedBox(),
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return AnimatedBuilder(
      animation: widget.fadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - widget.fadeAnimation.value) * 20),
          child: Opacity(
            opacity: widget.fadeAnimation.value,
            child: Text(
              'Voeurn Sovanmakara',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return AnimatedBuilder(
      animation: widget.fadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - widget.fadeAnimation.value) * 15),
          child: Opacity(
            opacity: widget.fadeAnimation.value,
            child: Text(
              'Flutter Developer | Mobile App Developer',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialButtons() {
    return AnimatedBuilder(
      animation: widget.fadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - widget.fadeAnimation.value) * 10),
          child: Opacity(
            opacity: widget.fadeAnimation.value,
            child: Wrap(
              spacing: 16.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: [
                _buildSocialButton(
                  SvgPicture.asset(
                    'assets/svg/mail.svg',
                    width: 24,
                    height: 24,
                  ),
                  'mailto:voeurnsovanmakara313@gmail.com',
                  'Email',
                ),
                _buildSocialButton(
                  SvgPicture.asset(
                    'assets/svg/linkedin.svg',
                    width: 24,
                    height: 24,
                  ),
                  'https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile',
                  'LinkedIn',
                ),
                _buildSocialButton(
                  SvgPicture.asset(
                    'assets/svg/github.svg',
                    width: 24,
                    height: 24,
                  ),
                  'https://github.com/itsshinra',
                  'GitHub',
                ),
                _buildSocialButton(
                  SvgPicture.asset(
                    'assets/svg/telegram.svg',
                    width: 24,
                    height: 24,
                  ),
                  'https://t.me/Sovan_Makara',
                  'Telegram',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialButton(Widget icon, String url, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (widget.animationController.value * 0.05),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: IconButton(
                icon: _isSocialLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : icon,
                onPressed: _isSocialLoading
                    ? null
                    : () async {
                        setState(() => _isSocialLoading = true);
                        try {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Could not launch $tooltip'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          debugPrint('Error launching $tooltip: $e');
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error opening $tooltip'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } finally {
                          if (mounted) setState(() => _isSocialLoading = false);
                        }
                      },
              ),
            ),
          );
        },
      ),
    );
  }
}
