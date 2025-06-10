import 'package:equatable/equatable.dart';
import 'package:sheba_pathway/models/blog_model.dart';

// EVENTS
abstract class BlogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBlogs extends BlogEvent {}

class PostBlog extends BlogEvent {
  final BlogModel blog;
  PostBlog(this.blog);

  @override
  List<Object?> get props => [blog];
}

class AddComment extends BlogEvent {
  final String blogId;
  final String author;
  final String text;
  AddComment(this.blogId, this.author, this.text);

  @override
  List<Object?> get props => [blogId, author, text];
}

class LikeBlog extends BlogEvent {
  final String blogId;
  final bool increment;
  LikeBlog(this.blogId, {this.increment = true});

  @override
  List<Object?> get props => [blogId, increment];
}

class StreamComments extends BlogEvent {
  final String blogId;
  StreamComments(this.blogId);

  @override
  List<Object?> get props => [blogId];
}