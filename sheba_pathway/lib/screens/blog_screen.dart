import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/widgets/blog_container.dart';
import 'package:sheba_pathway/widgets/loading_progress.dart';
import 'package:sheba_pathway/widgets/post_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_bloc.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_state.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_event.dart';
import 'package:sheba_pathway/widgets/toast.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        
        appBar: AppBar(
          
          title: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              "Blogs",
              style: largeText.copyWith(
                  color: black2, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => PostBlogDialog());
                },
                icon: Icon(Icons.add_box, color: black2.withOpacity(0.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                color:  black2.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/pp.jpg")),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: BlocProvider.value(
          value: BlocProvider.of<BlogBloc>(context)..add(LoadBlogs()),
          child: BlocConsumer<BlogBloc, BlogState>(
            listener: (context, state){
              if (state is BlogError) {
                return showErrorToast("Something went wrongon loading blogs.");
              }
            },
            builder: (context, state) {
              if (state is BlogLoading) {
                return loadingProgress(context);
              }
              if (state is BlogLoaded) {
                if (state.blogs.isEmpty) {
                  return Center(child: Text("No blogs yet.", style: mediumText.copyWith(color: whiteColor)));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];
                    return BlogContainer(
                      id: blog.id!,
                      imageUrl: blog.imageUrl!,
                      title: blog.tripName,
                      excerpt: blog.description,
                      author: blog.authorName,
                      date: blog.createdAt.toString().split(' ').first,
                      likes: blog.likes,
                      comments: blog.comments,
                    );
                  },
                );
              }
             
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}