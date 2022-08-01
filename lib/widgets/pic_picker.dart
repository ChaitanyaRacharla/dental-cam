import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

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
    );
    setState(() {
      _storedImage = File((imageFile as XFile).path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    print(appDir);
    final fileName = path.basename((_storedImage as File).path);
    final savedImage =
        await (_storedImage as File).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

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
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Click to add image'),
                  ),
                ),
              ),
      ),
    );
  }
}
