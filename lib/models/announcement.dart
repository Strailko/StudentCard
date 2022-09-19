import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String description;
  final String uid;
  final String title;
  final DateTime datePublished;
  final String imageUrl;

  const Announcement({
    required this.description,
    required this.uid,
    required this.title,
    required this.datePublished,
    required this.imageUrl,
  });

  static Announcement fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Announcement(
        description: snapshot["description"],
        uid: snapshot["uid"],
        title: snapshot["title"],
        datePublished: snapshot["datePublished"],
        imageUrl: snapshot["imageUrl"]);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "title": title,
        "datePublished": datePublished,
        "imageUrl": imageUrl
      };
}
