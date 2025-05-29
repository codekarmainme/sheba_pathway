import 'package:flutter/material.dart';

class DestnationTextContainer extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const DestnationTextContainer({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            // Description/History
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}