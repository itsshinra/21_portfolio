import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String skill;

  const SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        skill,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blueGrey[600],
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      avatar: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(
          skill[0], // First letter of the skill
          style: TextStyle(
              color: Colors.blueGrey[800], 
              fontWeight: FontWeight.bold,
            ),
        ),
      ),
    );
  }
}