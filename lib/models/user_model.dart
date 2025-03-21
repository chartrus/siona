class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoURL;
  final DateTime lastSignInTime;
  final DateTime createdTime;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL,
    required this.lastSignInTime,
    required this.createdTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'lastSignInTime': lastSignInTime.toIso8601String(),
      'createdTime': createdTime.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      photoURL: map['photoURL'],
      lastSignInTime: DateTime.parse(map['lastSignInTime'] as String),
      createdTime: DateTime.parse(map['createdTime'] as String),
    );
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    DateTime? lastSignInTime,
    DateTime? createdTime,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      lastSignInTime: lastSignInTime ?? this.lastSignInTime,
      createdTime: createdTime ?? this.createdTime,
    );
  }
} 