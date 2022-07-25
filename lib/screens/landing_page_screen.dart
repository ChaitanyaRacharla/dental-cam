import 'package:dentalcam/screens/view_patients.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:math' as math;

import 'view_image_screen.dart';
import '../providers/patients.dart';

class LandingPageScreen extends StatelessWidget {
  LandingPageScreen({Key? key}) : super(key: key);
  final _random = math.Random();
  _openApp(data) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients List'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(ViewImageScreen.routeName),
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<Patients>(context, listen: false).fetchAndSetPatients(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Patients>(
                builder: (ctx, patients, ch) => patients.items.isEmpty
                    ? ch!
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250),
                        itemBuilder: ((ctx, i) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                  ViewPatientsScreen.routeName,
                                  arguments: patients.items[i].id,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.primaries[_random
                                            .nextInt(Colors.primaries.length)]
                                        [_random.nextInt(9) * 100],
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(patients.items[i].title,
                                          style: const TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                ),
                              ),
                              // GridTile(
                              //   header: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Text(
                              //       patients.items[i].title,
                              //     ),
                              //   ),
                              //   child: Image.file(
                              //     patients.items[i].image,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                            )),
                        itemCount: patients.items.length,
                        // gridDelegate: () {},
                      ),
                child: const Center(
                  child: Text('No patients available'),
                ),
              ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () => _openApp('com.shenyaocn.android.usbcamera'),
            ),
          ),
          SpeedDialChild(
            child: IconButton(
              icon: const Icon(Icons.light_mode_sharp),
              onPressed: () =>
                  _openApp('com.giumig.apps.bluetoothserialmonitor'),
            ),
          ),
        ],
      ),
    );
  }
}
