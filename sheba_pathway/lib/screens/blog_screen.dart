import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/widgets/blog_container.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left:4.0),
            child: Text(
              "Blogs",
              style:
                  largeText.copyWith(color: black2, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundImage: AssetImage("assets/images/pp.jpg")),
          ),

          ],
        automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlogContainer(
                  imageUrl: 'assets/images/blog2.jpg',
                  title: 'Harar jugol',
                  excerpt:
                      'I had a good time in harar, ethiopia with a great experience and weather',
                  author: 'Elisa Brown',
                  date: 'June 25,2025'),
              BlogContainer(
                  imageUrl: 'assets/images/blog1.jpg',
                  title: 'Denakil',
                  excerpt:
                      'I had a good time in Denakil, Afar, ethiopia with a great experience and weather',
                  author: 'Joe Doe',
                  date: 'June 25,2025')
            ],
          ),
        ),
      ),
    );
  }
}
