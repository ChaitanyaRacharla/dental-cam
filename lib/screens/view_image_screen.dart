import 'package:dentalcam/providers/patients.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/pic_picker.dart';
import '../widgets/pic_picker2.dart';
import 'dart:io';

class ViewImageScreen extends StatefulWidget {
  const ViewImageScreen({Key? key}) : super(key: key);
  static const routeName = '/view-image';
  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  final _titleController = TextEditingController();
  final _ageController = TextEditingController();
  File? _pickedImage;
  File? _pickedImage2;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectImage2(File pickedImage2) {
    _pickedImage2 = pickedImage2;
  }

  final snackBar = const SnackBar(
    content: Text('Kindly enter all the required fields'),
    backgroundColor: Colors.red,
  );
  void _saveImage() {
    if (_titleController.text.isEmpty &&
        _pickedImage == null &&
        _ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Provider.of<Patients>(context, listen: false).addPatient(
      _titleController.text,
      _ageController.text,
      _pickedImage as File,
      _pickedImage2 as File,
    );
    Navigator.of(context).pop();
  }

  void _openINSKAM(data) async {
    String dt = data['INSKAM'] as String;
    const packageName = 'com.ypcc.otgcamera';
    bool isInstalled = await DeviceApps.isAppInstalled(packageName);
    if (isInstalled != false) {
      DeviceApps.openApp(packageName);
    } else {
      String url = dt;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patients'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5.0,
              ),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Patient name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5.0,
              ),
              child: TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Patient Age'),
                keyboardType: TextInputType.number,
              ),
            ),
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PicPicker(_selectImage),
                    // ToggleButtons(children: children, isSelected: isSelected)
                    PicPicker2(_selectImage2),
                  ]),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: _saveImage,
        color: Colors.green,
        focusColor: Colors.green,
        highlightColor: Colors.green,
        icon: const Icon(
          Icons.check,
          color: Colors.green,
        ),
      ),
    );
  }
}
