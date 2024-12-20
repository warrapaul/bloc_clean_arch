// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAHUsMITqHeTbgkfeg0nqQD_21es2fSTdg',
    appId: '1:627705383267:web:27e748bce73a5f508feb56',
    messagingSenderId: '627705383267',
    projectId: 'bloc-proj-9ac4c',
    authDomain: 'bloc-proj-9ac4c.firebaseapp.com',
    storageBucket: 'bloc-proj-9ac4c.firebasestorage.app',
    measurementId: 'G-B809K3R9WS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXQfS_am9h-0IySPlzxSBxzKmxMklTrUg',
    appId: '1:627705383267:android:41efea0c2b7d11568feb56',
    messagingSenderId: '627705383267',
    projectId: 'bloc-proj-9ac4c',
    storageBucket: 'bloc-proj-9ac4c.firebasestorage.app',
  );
}
