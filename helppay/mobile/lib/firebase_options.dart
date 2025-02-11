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
    apiKey: 'AIzaSyBQc9Tp1r_1sz6ZT2AI_fr8sjFqenvtiaU',
    appId: '1:4473626187:web:3aad81bf17d85d4b5f77ce',
    messagingSenderId: '4473626187',
    projectId: 'helppay-ba5e5',
    authDomain: 'helppay-ba5e5.firebaseapp.com',
    storageBucket: 'helppay-ba5e5.appspot.com',
    measurementId: 'G-57WJX3DDKT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYsDAL-RmO1adEGmS-X55fsSjW7qY8R8I',
    appId: '1:4473626187:android:bef7464b6a47a8635f77ce',
    messagingSenderId: '4473626187',
    projectId: 'helppay-ba5e5',
    storageBucket: 'helppay-ba5e5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkRnvhsaOt8M1LgrBFyuvX7pPkGtZ7FxI',
    appId: '1:4473626187:ios:198780d2f3f34edb5f77ce',
    messagingSenderId: '4473626187',
    projectId: 'helppay-ba5e5',
    storageBucket: 'helppay-ba5e5.appspot.com',
    iosClientId: '4473626187-kk7cct0hrh4nf7j5pglr0nuqvfqn1kk4.apps.googleusercontent.com',
    iosBundleId: 'by.mdom.helppay',
  );
}
