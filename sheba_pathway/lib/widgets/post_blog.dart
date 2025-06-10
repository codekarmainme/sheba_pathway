import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_bloc.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_event.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_state.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/models/blog_model.dart';
import 'package:sheba_pathway/widgets/loading_progress.dart';
import 'package:sheba_pathway/widgets/toast.dart';

class PostBlogDialog extends StatefulWidget {
  const PostBlogDialog({super.key});

  @override
  State<PostBlogDialog> createState() => _PostBlogDialogState();
}

class _PostBlogDialogState extends State<PostBlogDialog> {
  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogPosted) {
          Navigator.pop(context);
          showSuccessToast('Sucessfully posted');
        }
        if (state is BlogError) {
          showErrorToast(state.message);

        }
        if (state is BlogPosting) {
          showDialog(context: context, builder: (context){
            return loadingProgress(context);
          });
        }
      },
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Post a Blog",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _pickImage,
                    child: _selectedImage == null
                        ? Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                const Icon(FontAwesomeIcons.camera,
                                    size: 20, color: Colors.grey),
                                Text('Add image', style: normalText)
                              ],
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(_selectedImage!.path),
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _tripNameController,
                    decoration: InputDecoration(
                      labelText: "Trip Name",
                      labelStyle: normalText,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _descController,
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: normalText,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: grey1),
                            elevation: 0,
                          ),
                          child: Text("Cancel",
                              style: normalText.copyWith(color: black2)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final auth = FirebaseAuth.instance.currentUser;
                            context.read<BlogBloc>().add(PostBlog(BlogModel(
                                tripName: _tripNameController.text,
                                description: _descController.text,
                                authorId: auth!.uid,
                                authorName: auth.displayName ?? '',
                                createdAt: DateTime.now(),
                                imageUrl: _selectedImage?.path,
                                likes: 0,
                                comments: 0)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            elevation: 0,
                          ),
                          child: Text("Post",
                              style: normalText.copyWith(color: whiteColor)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
