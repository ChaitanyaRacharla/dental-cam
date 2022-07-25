import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class PicPicker2 extends StatefulWidget {
  // const PicPicker2({Key? key}) : super(key: key);
  final Function onSelectImage;
  PicPicker2(this.onSelectImage);

  @override
  State<PicPicker2> createState() => _PicPicker2State();
}

class _PicPicker2State extends State<PicPicker2> {
  File? _storedImage2;
  Future _takePicture2() async {
    final imageFile2 = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {
      _storedImage2 = File((imageFile2 as XFile).path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    print(appDir);
    final fileName2 = path.basename((_storedImage2 as File).path);
    final savedImage2 =
        await (_storedImage2 as File).copy('${appDir.path}/$fileName2');
    widget.onSelectImage(savedImage2);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 250,
        width: 400,
        child: _storedImage2 != null
            ? Image.file(
                (_storedImage2 as File),
                fit: BoxFit.cover,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 50,
                ),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: _takePicture2,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Click to add image'),
                  ),
                ),
              ),
      ),
    );
  }
}
