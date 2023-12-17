import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_rental/connection_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:house_rental/core/firebase/firebase_app_check.dart';
import 'package:oktoast/oktoast.dart';
import './firebase_options.dart';
import './locator.dart';

void main() async {
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([

   DeviceOrientation.portraitDown,
   DeviceOrientation.portraitUp 
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   await FirebaseAppCheckHelper.initialise();

  runApp(OKToast(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
        home: const ConnectionPage(), theme: ThemeData(useMaterial3: true),),
  ));
}
