class ProfileModel {
  final String displayName;
  final String email;
  final DateTime createdTime;
  final DateTime lastSignInTime;

  ProfileModel({
    required this.displayName,
    required this.email,
    required this.createdTime,
    required this.lastSignInTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'createdTime': createdTime.toIso8601String(),
      'lastSignInTime': lastSignInTime.toIso8601String(),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      createdTime: DateTime.parse(map['createdTime'] as String),
      lastSignInTime: DateTime.parse(map['lastSignInTime'] as String),
    );
  }

  ProfileModel copyWith({
    String? displayName,
    String? email,
    DateTime? createdTime,
    DateTime? lastSignInTime,
  }) {
    return ProfileModel(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      createdTime: createdTime ?? this.createdTime,
      lastSignInTime: lastSignInTime ?? this.lastSignInTime,
    );
  }
} 