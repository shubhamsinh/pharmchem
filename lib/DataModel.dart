import 'dart:io';

class Prescription {
  final int? id;
  final String image;
  final String ScannedText;

  Prescription({this.id, required this.image, required this.ScannedText});

  factory Prescription.fromMap(Map<String, dynamic> json) => Prescription(
      id: json['id'], image: json['image'], ScannedText: json['ScannedText']);

  Map<String, dynamic> toMap() =>
      {"id": id, "image": image, "ScannedText": ScannedText};
}
