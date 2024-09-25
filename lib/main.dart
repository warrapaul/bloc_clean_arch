import 'package:bloc_clean_arch/app.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(const App());
}
