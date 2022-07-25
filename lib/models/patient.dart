import 'dart:io';

class Patient {
  final String id;
  final String title;
  final String age;
  final File image;
  final File image2;

  Patient({
    required this.id,
    required this.title,
    required this.age,
    required this.image,
    required this.image2,
  });
}
