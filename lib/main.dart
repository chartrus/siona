import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siona',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Siona'),
        actions: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => AuthService().signOut(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return StreamBuilder<UserModel?>(
              stream: userService.getUserStream(snapshot.data!.uid),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final userData = userSnapshot.data;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (userData?.photoURL != null)
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(userData!.photoURL!),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        '환영합니다, ${userData?.displayName ?? "사용자"}님!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(userData?.email ?? ""),
                      const SizedBox(height: 8),
                      Text('마지막 로그인: ${userData?.lastSignInTime.toString() ?? ""}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => AuthService().signOut(),
                        child: const Text('로그아웃'),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final result = await AuthService().signInWithGoogle();
                  if (result == null) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('로그인이 취소되었습니다.')),
                      );
                    }
                  }
                } catch (e) {
                  print('로그인 에러 발생: $e');
                  if (context.mounted) {
                    String errorMessage = '알 수 없는 오류가 발생했습니다.';
                    
                    if (e is FirebaseAuthException) {
                      switch (e.code) {
                        case 'popup-blocked':
                          errorMessage = '팝업이 차단되었습니다. 팝업 차단을 해제해주세요.';
                          break;
                        case 'popup-closed-by-user':
                          errorMessage = '로그인 창이 닫혔습니다.';
                          break;
                        case 'unauthorized-domain':
                          errorMessage = '승인되지 않은 도메인입니다. Firebase Console에서 도메인을 확인해주세요.';
                          break;
                        default:
                          errorMessage = '로그인 오류: ${e.message}';
                      }
                    }
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(errorMessage)),
                    );
                  }
                }
              },
              child: const Text('Google Sign In'),
            ),
          );
        },
      ),
    );
  }
} 