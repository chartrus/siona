import 'package:hive/hive.dart';

part 'soul_state.g.dart';

@HiveType(typeId: 0)
class SoulState extends HiveObject {
  @HiveField(0)
  double purificationLevel = 0.0; // 0.0 (검은색) to 1.0 (흰색)

  @HiveField(1)
  double energy = 1.0; // 0.0 to 1.0

  @HiveField(2)
  double prayer = 0.0; // 0.0 to 1.0

  @HiveField(3)
  bool isSleeping = false;

  @HiveField(4)
  DateTime lastPrayerTime = DateTime.now();

  @HiveField(5)
  DateTime lastMealTime = DateTime.now();

  void update(double dt) {
    // 에너지 감소
    if (!isSleeping) {
      energy = (energy - dt * 0.1).clamp(0.0, 1.0);
    } else {
      energy = (energy + dt * 0.2).clamp(0.0, 1.0);
    }

    // 정화도 증가 (에너지와 기도가 높을수록 더 빠르게)
    if (energy > 0.5 && prayer > 0.5) {
      purificationLevel = (purificationLevel + dt * 0.05).clamp(0.0, 1.0);
    }
  }

  void pray() {
    if (!isSleeping) {
      prayer = (prayer + 0.1).clamp(0.0, 1.0);
      lastPrayerTime = DateTime.now();
    }
  }

  void eat() {
    if (!isSleeping) {
      energy = (energy + 0.3).clamp(0.0, 1.0);
      lastMealTime = DateTime.now();
    }
  }

  void sleep() {
    isSleeping = true;
  }

  void wake() {
    isSleeping = false;
  }
} 