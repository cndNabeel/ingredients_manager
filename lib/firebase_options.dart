// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVgfXKlOIE7hUxxhhFHH-voY4l2Zx3Dbc',
    appId: '1:296298179093:android:0ff2a6e70182901d133c1c',
    messagingSenderId: '296298179093',
    projectId: 'my-newproject-ingredient1',
    databaseURL: 'https://my-newproject-ingredient1-default-rtdb.firebaseio.com',
    storageBucket: 'my-newproject-ingredient1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-J4rIJKJ5z2agvCYIPqHaud5a3AndETk',
    appId: '1:296298179093:ios:9f4c29b3e579d475133c1c',
    messagingSenderId: '296298179093',
    projectId: 'my-newproject-ingredient1',
    databaseURL: 'https://my-newproject-ingredient1-default-rtdb.firebaseio.com',
    storageBucket: 'my-newproject-ingredient1.appspot.com',
    iosBundleId: 'com.example.ingredientsManager',
  );
}
