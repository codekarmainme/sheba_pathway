import 'package:flutter/material.dart';
import 'package:sheba_pathway/widgets/review_container.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          ReviewContainer(),
          ReviewContainer()

        ],
      ),
    );
  }
}