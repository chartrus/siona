class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final DateTime lastSignInTime;
  final DateTime createdTime;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.lastSignInTime,
    required this.createdTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'lastSignInTime': lastSignInTime.toIso8601String(),
      'createdTime': createdTime.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      lastSignInTime: DateTime.parse(map['lastSignInTime'] as String),
      createdTime: DateTime.parse(map['createdTime'] as String),
    );
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    DateTime? lastSignInTime,
    DateTime? createdTime,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      lastSignInTime: lastSignInTime ?? this.lastSignInTime,
      createdTime: createdTime ?? this.createdTime,
    );
  }
} 