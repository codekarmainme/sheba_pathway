import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheba_pathway/models/blog_model.dart';

class BlogRepository {
  final CollectionReference _blogCollection =
      FirebaseFirestore.instance.collection('blogs');

  // Post a new blog
  Future<void> postBlog(BlogModel blog) async {
    await _blogCollection.add(blog.toJson());
  }

  // Stream all blogs (real-time updates)
  Stream<List<BlogModel>> streamBlogs() {
    return _blogCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BlogModel.fromJson(doc.data() as Map<String, dynamic>, id: doc.id))
            .toList());
  }

  // Retrieve all blogs (one-time fetch)
  Future<List<BlogModel>> fetchBlogsOnce() async {
    final snapshot = await _blogCollection.orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => BlogModel.fromJson(doc.data() as Map<String, dynamic>, id: doc.id))
        .toList();
  }

  // Add a comment to a blog (as a subcollection)
  Future<void> addComment(String blogId, String author, String text) async {
    final commentsCollection = _blogCollection.doc(blogId).collection('comments');
    await commentsCollection.add({
      'author': author,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
    // Optionally increment comment count
    await _blogCollection.doc(blogId).update({
      'comments': FieldValue.increment(1),
    });
  }

  // Like or unlike a blog
  Future<void> likeBlog(String blogId, {bool increment = true}) async {
    await _blogCollection.doc(blogId).update({
      'likes': FieldValue.increment(increment ? 1 : -1),
    });
  }

  // Stream comments for a blog
  Stream<List<Map<String, dynamic>>> streamComments(String blogId) {
    return _blogCollection
        .doc(blogId)
        .collection('comments')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data())
            .toList());
  }
}