import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb ? "977901277909-kodhvg94r4rp0fbcj58lo5qgbpusnf60.apps.googleusercontent.com" : null,
    scopes: ['email', 'profile'],
  );

  // 현재 사용자 상태 스트림
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Google 로그인
  Future<UserCredential?> signInWithGoogle() async {
    try {
      print('=== Google 로그인 시작 ===');
      print('웹 환경: $kIsWeb');
      print('클라이언트 ID: ${_googleSignIn.clientId}');

      if (kIsWeb) {
        // 웹 환경에서는 Firebase Auth Provider를 직접 사용
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        
        // 필수 OAuth 2.0 스코프
        googleProvider.addScope('https://www.googleapis.com/auth/userinfo.email');
        googleProvider.addScope('https://www.googleapis.com/auth/userinfo.profile');
        
        // 추가 설정
        googleProvider.setCustomParameters({
          'prompt': 'select_account'
        });
        
        // Firebase Auth로 직접 로그인
        try {
          final UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
          print('팝업 로그인 성공: ${userCredential.user?.email}');
          return userCredential;
        } catch (e) {
          print('팝업 로그인 실패, 리디렉션 시도: $e');
          await _auth.signInWithRedirect(googleProvider);
          return await _auth.getRedirectResult();
        }
      } else {
        // 모바일 환경에서는 GoogleSignIn 사용
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        
        if (googleUser == null) {
          print('Google 로그인 취소됨');
          return null;
        }

        print('Google 로그인 성공 - 이메일: ${googleUser.email}');

        // 인증 세부 정보 얻기
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        
        // Firebase credential 생성
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Firebase 로그인
        return await _auth.signInWithCredential(credential);
      }
    } catch (e, stackTrace) {
      print('=== Google 로그인 실패 ===');
      print('에러: $e');
      print('스택 트레이스: $stackTrace');
      rethrow;
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
} 