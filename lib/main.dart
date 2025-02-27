import 'package:bloc_clean_arch/app.dart';
import 'package:bloc_clean_arch/core/firebase/firebase_notifications_api.dart';
import 'package:bloc_clean_arch/firebase_options.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   // Initialize storage services
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  

  setUpServiceLocator(
    sharedPreferences: sharedPreferences,
    secureStorage: secureStorage,
  );

// TO DO: ADD FIREBASE PUSH NOTIFICATIONS
  // await FirebaseNotificationService.instance.setup();


  runApp(const App());
}




