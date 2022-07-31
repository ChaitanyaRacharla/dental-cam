import 'dart:io';

class Patient {
  final String id;
  final String title;
  final String age;
  final File image;
  final File image2;
  final File image3;
  final String description;

  Patient({
    required this.id,
    required this.title,
    required this.age,
    required this.image,
    required this.image2,
    required this.image3,
    required this.description,
  });
}
