import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/login_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyBUowHFFgnSAJ7Id7QeTrdPmdF4eOgE29g",
          authDomain: "siona-ec08b.firebaseapp.com",
          projectId: "siona-ec08b",
          storageBucket: "siona-ec08b.appspot.com",
          messagingSenderId: "977901277909",
          appId: "1:977901277909:web:f0335679a64920ea98085c"
        ),
      );
      print('Firebase 웹 초기화 완료');
    } else {
      await Firebase.initializeApp();
      print('Firebase 네이티브 초기화 완료');
    }

    runApp(const MyApp());
  } catch (e, stackTrace) {
    print('Firebase 초기화 에러: $e');
    print('스택 트레이스: $stackTrace');
    runApp(const ErrorApp());
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            '앱 초기화 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siona',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// 임시 HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siona'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to Siona!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} 