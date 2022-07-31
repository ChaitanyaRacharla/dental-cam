import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class PicPicker3 extends StatefulWidget {
  // const PicPicker3({Key? key}) : super(key: key);
  final Function onSelectImage;
  PicPicker3(this.onSelectImage);

  @override
  State<PicPicker3> createState() => _PicPicker3State();
}

class _PicPicker3State extends State<PicPicker3> {
  File? _storedImage3;
  Future _takePicture3() async {
    final imageFile3 = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {
      _storedImage3 = File((imageFile3 as XFile).path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    print(appDir);
    final fileName3 = path.basename((_storedImage3 as File).path);
    final savedImage3 =
        await (_storedImage3 as File).copy('${appDir.path}/$fileName3');
    widget.onSelectImage(savedImage3);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 250,
        width: 400,
        child: _storedImage3 != null
            ? Image.file(
                (_storedImage3 as File),
                fit: BoxFit.cover,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 50,
                ),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: _takePicture3,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Click to add image'),
                  ),
                ),
              ),
      ),
    );
  }
}
