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
        return macos;
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
    apiKey: 'AIzaSyCbxqYajAe4Cb1ehdjn5-hAupRv3k-TEWo',
    appId: '1:1077419995531:web:54f98a6e37a9c41308ff8e',
    messagingSenderId: '1077419995531',
    projectId: 'grocerystore-87967',
    authDomain: 'grocerystore-87967.firebaseapp.com',
    storageBucket: 'grocerystore-87967.appspot.com',
    measurementId: 'G-2E0GGGYQEC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBN6RyM2Pw8v1U_-2GlszWHFYOQ9ue296w',
    appId: '1:1077419995531:android:279e67efa4d9575e08ff8e',
    messagingSenderId: '1077419995531',
    projectId: 'grocerystore-87967',
    storageBucket: 'grocerystore-87967.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-tmeCp_wD3YH1HWn85Dw9L6KDBpI7ywA',
    appId: '1:1077419995531:ios:fd0251bc9600d60908ff8e',
    messagingSenderId: '1077419995531',
    projectId: 'grocerystore-87967',
    storageBucket: 'grocerystore-87967.appspot.com',
    iosClientId:
        '1077419995531-q5323uqfe4jloks96v04t3bi6puipjgn.apps.googleusercontent.com',
    iosBundleId: 'com.example.blocProjectTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-tmeCp_wD3YH1HWn85Dw9L6KDBpI7ywA',
    appId: '1:1077419995531:ios:763528edbaaa6e9c08ff8e',
    messagingSenderId: '1077419995531',
    projectId: 'grocerystore-87967',
    storageBucket: 'grocerystore-87967.appspot.com',
    iosClientId:
        '1077419995531-ngj4kid7l4d5ifi525bpqpa9qql6gj6h.apps.googleusercontent.com',
    iosBundleId: 'com.example.blocProjectTest.RunnerTests',
  );
}
