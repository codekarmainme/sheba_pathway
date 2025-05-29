import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';

class BlogContainer extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String excerpt;
  final String author;
  final String date;
  final VoidCallback? onTap;

  const BlogContainer({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.excerpt,
    required this.author,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog Image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: grey1,
                  child: Icon(Icons.image, color: grey1, size: 60),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Text(
                title,
                style: heading6.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                excerpt,
                style: normalText.copyWith(color: black3),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              child: Row(
                children: [
                  Icon(Icons.person, size: 16, color: grey1),
                  const SizedBox(width: 6),
                  Text(
                    author,
                    style: smallText.copyWith(color: black2),
                  ),
                  const Spacer(),
                  Icon(Icons.calendar_today, size: 15, color: grey1),
                  const SizedBox(width: 4),
                  Text(
                    date,
                    style: smallText.copyWith(color: black2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}