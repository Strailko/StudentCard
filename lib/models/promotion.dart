import 'package:cloud_firestore/cloud_firestore.dart';

class Promotion {
  final String name;
  final String title;
  final String discount;
  final String imageUrl;
  final String uid;
  final DateTime datePublished;

  const Promotion(
      {required this.name,
      required this.title,
      required this.uid,
      required this.imageUrl,
      required this.discount,
      required this.datePublished});

  static Promotion fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Promotion(
        name: snapshot["name"],
        title: snapshot["title"],
        uid: snapshot["uid"],
        discount: snapshot["discount"],
        imageUrl: snapshot["imageUrl"],
        datePublished: snapshot["datePublished"]);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "uid": uid,
        "discount": discount,
        "imageUrl": imageUrl,
        "datePublished": datePublished
      };
}
