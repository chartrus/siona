import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  // 사용자 정보 저장 또는 업데이트
  Future<void> saveUserData(User firebaseUser) async {
    try {
      // 기존 사용자 데이터 확인
      final userDoc = await _usersCollection.doc(firebaseUser.uid).get();
      final now = DateTime.now();

      if (userDoc.exists) {
        // 기존 사용자의 경우 마지막 로그인 시간만 업데이트
        await _usersCollection.doc(firebaseUser.uid).update({
          'lastSignInTime': now.toIso8601String(),
        });
      } else {
        // 새로운 사용자의 경우 전체 정보 저장
        final userData = UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? '',
          photoURL: firebaseUser.photoURL,
          lastSignInTime: now,
          createdTime: now,
        );

        await _usersCollection.doc(firebaseUser.uid).set(userData.toMap());
      }
    } catch (e) {
      print('사용자 데이터 저장 오류: $e');
      rethrow;
    }
  }

  // 사용자 정보 가져오기
  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('사용자 데이터 조회 오류: $e');
      return null;
    }
  }

  // 사용자 정보 스트림
  Stream<UserModel?> getUserStream(String uid) {
    return _usersCollection.doc(uid).snapshots().map((doc) {
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
} 