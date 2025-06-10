import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String? id;
  final String tripName;
  final String description;
  final String authorId;
  final String authorName;
  final String? imageUrl;
  final DateTime createdAt;
  final int likes;
  final int comments;

  BlogModel({
    this.id,
    required this.tripName,
    required this.description,
    required this.authorId,
    required this.authorName,
    this.imageUrl,
    required this.createdAt,
    this.likes = 0,
    this.comments = 0,
  });

  Map<String, dynamic> toJson() => {
        'tripName': tripName,
        'description': description,
        'authorId': authorId,
        'authorName': authorName,
        'imageUrl': imageUrl,
        'createdAt': createdAt,
        'likes': likes,
        'comments': comments,
      };

  factory BlogModel.fromJson(Map<String, dynamic> json, {String? id}) => BlogModel(
        id: id,
        tripName: json['tripName'] ?? '',
        description: json['description'] ?? '',
        authorId: json['authorId'] ?? '',
        authorName: json['authorName'] ?? '',
        imageUrl: json['imageUrl'],
        createdAt: (json['createdAt'] is Timestamp)
            ? (json['createdAt'] as Timestamp).toDate()
            : DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        likes: json['likes'] ?? 0,
        comments: json['comments'] ?? 0,
      );
}