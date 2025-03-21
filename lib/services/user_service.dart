import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/profile_model.dart';
import '../models/game_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 프로필 정보 저장 또는 업데이트
  Future<void> saveUserProfile(User firebaseUser) async {
    try {
      final profileRef = _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .collection('profile')
          .doc('info');

      final profileDoc = await profileRef.get();
      final now = DateTime.now();

      if (profileDoc.exists) {
        // 기존 사용자의 경우 마지막 로그인 시간만 업데이트
        await profileRef.update({
          'lastSignInTime': now.toIso8601String(),
        });
      } else {
        // 새로운 사용자의 경우 전체 프로필 정보 저장
        final profileData = ProfileModel(
          displayName: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          createdTime: now,
          lastSignInTime: now,
        );

        await profileRef.set(profileData.toMap());

        // 새 사용자의 경우 게임 데이터도 초기화
        await initializeGameData(firebaseUser.uid);
      }
    } catch (e) {
      print('프로필 데이터 저장 오류: $e');
      rethrow;
    }
  }

  // 게임 데이터 초기화
  Future<void> initializeGameData(String uid) async {
    try {
      final gameRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('game')
          .doc('progress');

      final gameData = GameModel.initial();
      await gameRef.set(gameData.toMap());
    } catch (e) {
      print('게임 데이터 초기화 오류: $e');
      rethrow;
    }
  }

  // 프로필 정보 스트림
  Stream<ProfileModel?> getProfileStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('profile')
        .doc('info')
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return ProfileModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  // 게임 데이터 스트림
  Stream<GameModel?> getGameDataStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('game')
        .doc('progress')
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return GameModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  // 게임 데이터 업데이트
  Future<void> updateGameData(String uid, GameModel gameData) async {
    try {
      final gameRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('game')
          .doc('progress');

      await gameRef.update(gameData.toMap());
    } catch (e) {
      print('게임 데이터 업데이트 오류: $e');
      rethrow;
    }
  }
} 