import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';

class GroupTripDiscussionWidget extends StatefulWidget {
  const GroupTripDiscussionWidget({super.key});

  @override
  State<GroupTripDiscussionWidget> createState() => _GroupTripDiscussionWidgetState();
}

class _GroupTripDiscussionWidgetState extends State<GroupTripDiscussionWidget> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> thoughts = [
    {
      'author': 'Miki',
      'text': 'Is there a packing list for this trip?',
      'likes': 2,
      'replies': [
        {'author': 'Guide', 'text': 'Yes! We will share it soon.'}
      ]
    },
    {
      'author': 'Sara',
      'text': 'Can I join from Bahir Dar?',
      'likes': 1,
      'replies': []
    },
  ];

  void _addThought(String text) {
    setState(() {
      thoughts.add({
        'author': 'You',
        'text': text,
        'likes': 0,
        'replies': []
      });
    });
    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  void _addReply(int index, String replyText) {
    setState(() {
      thoughts[index]['replies'].add({'author': 'You', 'text': replyText});
    });
  }

  void _likeThought(int index) {
    setState(() {
      thoughts[index]['likes'] += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.comments, color: primaryColor, size: 18),
                const SizedBox(width: 8),
                Text(
                  "Group Trip Q&A & Thoughts",
                  style: mediumText.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: thoughts.isEmpty
                  ? Center(
                      child: Text(
                        "No questions or thoughts yet.",
                        style: smallText.copyWith(color: grey1),
                      ),
                    )
                  : ListView.builder(
                      itemCount: thoughts.length,
                      itemBuilder: (context, index) {
                        final thought = thoughts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person, color: primaryColor, size: 18),
                                    const SizedBox(width: 6),
                                    Text(
                                      thought['author'],
                                      style: smallText.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: Icon(FontAwesomeIcons.thumbsUp, size: 16, color: successColor),
                                      onPressed: () => _likeThought(index),
                                    ),
                                    Text(thought['likes'].toString(),
                                        style: smallText.copyWith(color: successColor)),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    thought['text'],
                                    style: normalText,
                                  ),
                                ),
                                if (thought['replies'].isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, top: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ...thought['replies'].map<Widget>((reply) => Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.reply, size: 14, color: primaryColor),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    reply['author'],
                                                    style: smallText.copyWith(
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      reply['text'],
                                                      style: normalText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, top: 4),
                                  child: ReplyInput(
                                    onReply: (replyText) => _addReply(index, replyText),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask a question or share a thought...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: grey1),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    style: normalText,
                    onSubmitted: (text) {
                      if (text.trim().isNotEmpty) _addThought(text.trim());
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(FontAwesomeIcons.paperPlane, color: primaryColor),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) _addThought(text);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReplyInput extends StatefulWidget {
  final void Function(String) onReply;
  const ReplyInput({super.key, required this.onReply});

  @override
  State<ReplyInput> createState() => _ReplyInputState();
}

class _ReplyInputState extends State<ReplyInput> {
  final TextEditingController _replyController = TextEditingController();
  bool _showReply = false;

  @override
  Widget build(BuildContext context) {
    return _showReply
        ? Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _replyController,
                  decoration: InputDecoration(
                    hintText: "Write a reply...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: grey1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  style: normalText,
                  onSubmitted: (text) {
                    if (text.trim().isNotEmpty) {
                      widget.onReply(text.trim());
                      _replyController.clear();
                      setState(() => _showReply = false);
                    }
                  },
                ),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.paperPlane, color: primaryColor, size: 18),
                onPressed: () {
                  final text = _replyController.text.trim();
                  if (text.isNotEmpty) {
                    widget.onReply(text);
                    _replyController.clear();
                    setState(() => _showReply = false);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => setState(() => _showReply = false),
              ),
            ],
          )
        : TextButton(
            child: Text("Reply", style: smallText.copyWith(color: primaryColor)),
            onPressed: () => setState(() => _showReply = true),
          );
  }
}