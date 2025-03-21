class GameModel {
  final int level;
  final int exp;
  final int hunger;
  final int happiness;
  final DateTime lastPlayed;

  GameModel({
    required this.level,
    required this.exp,
    required this.hunger,
    required this.happiness,
    required this.lastPlayed,
  });

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'exp': exp,
      'hunger': hunger,
      'happiness': happiness,
      'lastPlayed': lastPlayed.toIso8601String(),
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      level: map['level'] ?? 1,
      exp: map['exp'] ?? 0,
      hunger: map['hunger'] ?? 100,
      happiness: map['happiness'] ?? 100,
      lastPlayed: map['lastPlayed'] != null 
        ? DateTime.parse(map['lastPlayed'] as String)
        : DateTime.now(),
    );
  }

  // 새로운 게임 데이터 생성을 위한 팩토리 생성자
  factory GameModel.initial() {
    return GameModel(
      level: 1,
      exp: 0,
      hunger: 100,
      happiness: 100,
      lastPlayed: DateTime.now(),
    );
  }

  GameModel copyWith({
    int? level,
    int? exp,
    int? hunger,
    int? happiness,
    DateTime? lastPlayed,
  }) {
    return GameModel(
      level: level ?? this.level,
      exp: exp ?? this.exp,
      hunger: hunger ?? this.hunger,
      happiness: happiness ?? this.happiness,
      lastPlayed: lastPlayed ?? this.lastPlayed,
    );
  }
} 