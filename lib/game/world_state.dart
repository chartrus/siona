import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WorldState extends ChangeNotifier {
  DateTime _gameTime = DateTime(2024, 1, 1, 6, 0); // 게임 시작 시간: 오전 6시
  double _ambientLight = 0.6; // 기본 환경광
  bool _isRaining = false;
  bool _isSnowing = false;
  double _rainIntensity = 0.0;
  double _snowIntensity = 0.0;
  Color _skyColor = const Color(0xFF87CEEB); // 기본 하늘색

  // Getters
  DateTime get gameTime => _gameTime;
  double get ambientLight => _ambientLight;
  bool get isRaining => _isRaining;
  bool get isSnowing => _isSnowing;
  double get rainIntensity => _rainIntensity;
  double get snowIntensity => _snowIntensity;
  Color get skyColor => _skyColor;

  // 시간 업데이트
  void updateTime(Duration duration) {
    _gameTime = _gameTime.add(duration);
    _updateAmbientLight();
    notifyListeners();
  }

  // 날씨 업데이트
  void updateWeather() {
    // 간단한 날씨 시스템
    if (_gameTime.hour >= 6 && _gameTime.hour < 18) {
      // 낮 시간대
      _isRaining = false;
      _isSnowing = false;
      _rainIntensity = 0.0;
      _snowIntensity = 0.0;
    } else {
      // 밤 시간대
      _isRaining = _gameTime.hour % 2 == 0;
      _isSnowing = _gameTime.hour % 3 == 0;
      _rainIntensity = _isRaining ? 0.5 : 0.0;
      _snowIntensity = _isSnowing ? 0.3 : 0.0;
    }
    notifyListeners();
  }

  // 환경광 업데이트
  void _updateAmbientLight() {
    // 시간에 따른 환경광 조절
    if (_gameTime.hour >= 6 && _gameTime.hour < 18) {
      // 낮 시간대
      _ambientLight = 0.8;
      _skyColor = const Color(0xFF87CEEB); // 하늘색
    } else if (_gameTime.hour >= 18 && _gameTime.hour < 20) {
      // 황혼
      _ambientLight = 0.6;
      _skyColor = const Color(0xFFFFA07A); // 연한 연어색
    } else if (_gameTime.hour >= 20 || _gameTime.hour < 6) {
      // 밤 시간대
      _ambientLight = 0.3;
      _skyColor = const Color(0xFF191970); // 진한 남색
    }
    notifyListeners();
  }
} 