import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';

class ViewPatientsScreen extends StatelessWidget {
  static const routeName = '/patient-detail';

  const ViewPatientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectedPatient =
        Provider.of<Patients>(context, listen: false).findById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedPatient.title} - ${selectedPatient.age}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Description',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedPatient.description,
                      textScaleFactor: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.file(
                  selectedPatient.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.file(
                  selectedPatient.image2,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.file(
                  selectedPatient.image3,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
