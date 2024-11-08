import 'package:bloc_clean_arch/app.dart';
import 'package:bloc_clean_arch/core/firebase/firebase_notifications_api.dart';
import 'package:bloc_clean_arch/firebase_options.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setUpServiceLocator();

  await FirebaseNotificationService.instance.setup();


  runApp(App());
}




