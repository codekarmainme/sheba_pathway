import 'package:equatable/equatable.dart';
import 'package:sheba_pathway/models/blog_model.dart';

abstract class BlogState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<BlogModel> blogs;
  BlogLoaded(this.blogs);

  @override
  List<Object?> get props => [blogs];
}

class BlogError extends BlogState {
  final String message;
  BlogError(this.message);

  @override
  List<Object?> get props => [message];
}

class BlogPosting extends BlogState {}

class BlogPosted extends BlogState {}

class CommentAdded extends BlogState {}

class BlogLiked extends BlogState {}

class CommentsLoading extends BlogState {}

class CommentsLoaded extends BlogState {
  final List<Map<String, dynamic>> comments;
  CommentsLoaded(this.comments);

  @override
  List<Object?> get props => [comments];
}

class CommentsError extends BlogState {
  final String message;
  CommentsError(this.message);

  @override
  List<Object?> get props => [message];
}
