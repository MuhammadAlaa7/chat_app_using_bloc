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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC7MyiuDGKnITky2HgQfq7asHDL3ZfHvKI',
    appId: '1:328310755651:web:b490d34530aa9c05d15ff6',
    messagingSenderId: '328310755651',
    projectId: 'chat-app-82b30',
    authDomain: 'chat-app-82b30.firebaseapp.com',
    storageBucket: 'chat-app-82b30.appspot.com',
    measurementId: 'G-Q5LCKBHETT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCl-DqdAhDoyZulG7OExzcKdBdVT4aHiKI',
    appId: '1:328310755651:android:99a92d59975ad447d15ff6',
    messagingSenderId: '328310755651',
    projectId: 'chat-app-82b30',
    storageBucket: 'chat-app-82b30.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_ewyefcVo18kw7bfvOgEdOt5FKrtZIoQ',
    appId: '1:328310755651:ios:2e7bfd9bda19c254d15ff6',
    messagingSenderId: '328310755651',
    projectId: 'chat-app-82b30',
    storageBucket: 'chat-app-82b30.appspot.com',
    iosBundleId: 'com.example.scholarChat',
  );
}
