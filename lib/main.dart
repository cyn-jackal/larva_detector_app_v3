import 'package:flutter/material.dart';
// import 'package:larva_detector_app/models/image_model.dart';
// import 'package:larva_detector_app/pages/home_page.dart';
// import 'package:larva_detector_app/themes/dark_theme.dart';
import 'package:larva_detector_app_v3/models/image_model.dart';
import 'package:larva_detector_app_v3/pages/home_page.dart';
import 'package:larva_detector_app_v3/themes/dark_theme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // await dotenv.load(fileName: "../.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: darkMode,
          title: 'Lerva Detector',
          home: LoaderOverlay(child: HomePage())),
    );
  }
}
