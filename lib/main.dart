import 'package:dentalcam/screens/view_patients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/patients.dart';
import 'screens/landing_page_screen.dart';
import 'screens/view_image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Patients(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dental Cam',
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: LandingPageScreen(),
        routes: {
          ViewImageScreen.routeName: (context) => const ViewImageScreen(),
          ViewPatientsScreen.routeName: (context) => const ViewPatientsScreen(),
        },
      ),
    );
  }
}
