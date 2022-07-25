import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:url_launcher/url_launcher.dart';
import 'package:camera/camera.dart';

class PicPicker extends StatefulWidget {
  // const PicPicker({Key? key}) : super(key: key);
  final Function onSelectImage;
  PicPicker(this.onSelectImage);

  @override
  State<PicPicker> createState() => _PicPickerState();
}

class _PicPickerState extends State<PicPicker> {
  File? _storedImage;
  Future _takePicture() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
      maxHeight: 400,
    );
    setState(() {
      _storedImage = File((imageFile as XFile).path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename((_storedImage as File).path);
    final savedImage =
        await (_storedImage as File).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  _openINSKAM(data) async {
    // String dt = data['INSKAM'] as String;
    // const packageName = 'com.ypcc.otgcamera';
    bool isInstalled = await DeviceApps.isAppInstalled(data);
    if (isInstalled != false) {
      DeviceApps.openApp(data);
    } else {
      String url = data;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Future _usbExternal() async {
    final _cameras = await availableCameras();
    final camera = _cameras[2];
  }
  // Map<String> data

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 250,
        width: 400,
        child: _storedImage != null
            ? Image.file(
                (_storedImage as File),
                fit: BoxFit.cover,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 50,
                ),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: _takePicture,
                    // onPressed: () => _openINSKAM('com.ypcc.otgcamera'),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Click to add image'),
                  ),
                ),
              ),
      ),
    );
  }
}
