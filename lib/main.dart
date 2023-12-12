import 'package:flutter/material.dart';
import 'package:house_rental/connection_page.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';
import './locator.dart';

void main() async {
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MaterialApp(home:const ConnectionPage(),
  theme: ThemeData(
    useMaterial3: true
  )));
}
