import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_event.dart';
import 'package:sheba_pathway/bloc/blog_bloc/blog_state.dart';
import 'package:sheba_pathway/models/blog_model.dart';
import 'package:sheba_pathway/repository/blog_repository.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;
  Stream<List<BlogModel>>? _blogStream;

  BlogBloc(this.blogRepository) : super(BlogInitial()) {
    on<LoadBlogs>((event, emit) async {
      emit(BlogLoading());
      try {
        _blogStream = blogRepository.streamBlogs();
        await emit.forEach<List<BlogModel>>(
          _blogStream!,
          onData: (blogs) => BlogLoaded(blogs),
          onError: (e, _) => BlogError(e.toString()),
        );
      } catch (e) {
        emit(BlogError(e.toString()));
      }
    });

    on<PostBlog>((event, emit) async {
      emit(BlogPosting());
      try {
        await blogRepository.postBlog(event.blog);
        emit(BlogPosted());
      } catch (e) {
        emit(BlogError(e.toString()));
      }
    });
    on<StreamComments>((event, emit) async {
      emit(CommentsLoading());
      try {
        await emit.forEach<List<Map<String, dynamic>>>(
          blogRepository.streamComments(event.blogId),
          onData: (comments) => CommentsLoaded(comments),
          onError: (e, _) => CommentsError(e.toString()),
        );
      } catch (e) {
        emit(CommentsError(e.toString()));
      }
    });
    on<AddComment>((event, emit) async {
      try {
        await blogRepository.addComment(event.blogId, event.author, event.text);
      } catch (e) {
        emit(BlogError(e.toString()));
      }
    });

    on<LikeBlog>((event, emit) async {
      try {
        await blogRepository.likeBlog(event.blogId, increment: event.increment);
      } catch (e) {
        emit(BlogError(e.toString()));
      }
    });
  }
}
