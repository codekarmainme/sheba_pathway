import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_bloc.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_event.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/repository/blog_repository.dart';
import 'package:sheba_pathway/widgets/comment_section.dart';

class BlogContainer extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String title;
  final String excerpt;
  final String author;
  final String date;
  final VoidCallback? onTap;
  final int likes;
  final int comments;
  const BlogContainer({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.excerpt,
    required this.author,
    required this.date,
    this.likes = 0,
    this.comments = 0,
    this.onTap,
  });

  @override
  State<BlogContainer> createState() => _BlogContainerState();
}

class _BlogContainerState extends State<BlogContainer> {
  bool isLikedbyyou = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: black2,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blog Image
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.file(
              File(widget.imageUrl),
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
              widget.title,
              style: heading6.copyWith(
                color: successColor,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.excerpt,
              style: normalText.copyWith(color: whiteColor),
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
                  widget.author,
                  style: smallText.copyWith(color: whiteColor),
                ),
                const Spacer(),
                Icon(Icons.calendar_today, size: 15, color: grey1),
                const SizedBox(width: 4),
                Text(
                  widget.date,
                  style: smallText.copyWith(color: whiteColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context
                        .read<BlogBloc>()
                        .add(LikeBlog(widget.id, increment: !isLikedbyyou));
                  },
                  icon: Icon(
                      isLikedbyyou
                          ? FontAwesomeIcons.solidThumbsUp
                          : FontAwesomeIcons.thumbsUp,
                      color: isLikedbyyou ? successColor : grey1),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                Text(
                  widget.likes.toString(),
                  style: smallText.copyWith(color: whiteColor),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CommentSection(
                        blogId: widget.id,
                        onSend: (text) {
                          context
                              .read<BlogBloc>()
                              .add(AddComment(widget.id, "You", text));
                        },
                         blogRepository: context.read<BlogRepository>(),
                      ),
                    );
                  },
                  icon: Icon(FontAwesomeIcons.comment, color: grey1),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                Text(
                  widget.comments.toString(),
                  style: smallText.copyWith(color: whiteColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
