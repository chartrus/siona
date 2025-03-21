import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // 다른 플랫폼에 대한 옵션은 현재 웹만 필요하므로 생략
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBrJoJPyhYWjvzxwiEPkZHZq7C29UYseSI',
    appId: '1:977901277909:web:f0335679a64920ea98085c',
    messagingSenderId: '977901277909',
    projectId: 'siona-ec08b',
    authDomain: 'siona-ec08b.firebaseapp.com',
    storageBucket: 'siona-ec08b.appspot.com',
  );
} 