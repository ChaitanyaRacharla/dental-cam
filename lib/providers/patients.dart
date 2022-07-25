import 'dart:io';

import 'package:dentalcam/helpers/sql_helper.dart';
import 'package:flutter/foundation.dart';

import '../models/patient.dart';

class Patients with ChangeNotifier {
  final List<Patient> _items = [];

  List<Patient> get items {
    return [..._items];
  }

  Patient findById(String id) {
    return _items.firstWhere((patient) => patient.id == id);
  }

  void addPatient(
    String pickedTitle,
    String pickedAge,
    File pickedImage,
    File pickedImage2,
  ) {
    final newPatient = Patient(
      id: DateTime.now().toString(),
      title: pickedTitle,
      age: pickedAge,
      image: pickedImage,
      image2: pickedImage2,
    );
    _items.add(newPatient);
    notifyListeners();
    SQLHelper.insert(
      'patients',
      {
        'id': newPatient.id,
        'title': newPatient.title,
        'age': newPatient.age,
        'image': newPatient.image,
        'image2': newPatient.image2
      },
    );
  }

  Future<void> fetchAndSetPatients() async {
    final dataList = await SQLHelper.getData('patients');
    dataList
        .map((item) => Patient(
              id: item['id'],
              title: item['title'],
              age: item['age'],
              image: File(item['image']),
              image2: File(item['image2']),
            ))
        .toList();
    notifyListeners();
  }
}
