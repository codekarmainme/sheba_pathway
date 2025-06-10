import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_bloc.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_event.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_state.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/repository/blog_repository.dart';
import 'package:sheba_pathway/widgets/error_container.dart';
import 'package:sheba_pathway/widgets/loading_progress.dart';

class CommentSection extends StatefulWidget {
  final String blogId;
  final void Function(String) onSend;
  final BlogRepository blogRepository;

  const CommentSection({
    super.key,
    required this.blogId,
    required this.onSend,
    required this.blogRepository,
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(StreamComments(widget.blogId));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Text(
                    "Comments",
                    style: mediumText.copyWith(
                      color: black2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(FontAwesomeIcons.xmark, color: grey1),
                  alignment: Alignment.topRight,
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<BlogBloc,BlogState>(
                builder: (context, state) {
                  if (state is CommentsLoading) {
                    return loadingProgress(context);
                  }
                  
                 if(state is CommentsLoaded){
                  final comments=state.comments ?? [];
                    if (comments.isEmpty) {
                    return Center(
                      child: Text(
                        "Be the first comment",
                        style: smallText.copyWith(color: grey1),
                      ),
                    );
                  }
                    return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: primaryColor.withOpacity(0.1),
                          child: Icon(Icons.person, color: primaryColor),
                        ),
                        title: Text(
                          comment['author'] ?? 'Anonymous',
                          style: smallText.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          comment['text'] ?? '',
                          style: normalText,
                        ),
                      );
                    },
                  );
                 }
                if (state is CommentsError) {
                return Center(child: Text(state.message,style: normalText,));
              }
                return SizedBox();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Add a comment...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: grey1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                      style: normalText,
                      onSubmitted: (_) => _handleSend(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon:
                        Icon(FontAwesomeIcons.paperPlane, color: primaryColor),
                    onPressed: _handleSend,
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
