import 'package:flutter/material.dart';
import 'package:house_rental/connection_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MaterialApp(home: ConnectionPage()));
}
