import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../my_game.dart';

class SplashScene extends Component with HasGameRef<MyGame> {
  late final TextComponent titleText;
  late final Timer timer;
  
  @override
  Future<void> onLoad() async {
    // 타이틀 텍스트
    titleText = TextComponent(
      text: 'SIONA',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2 - 20),
      anchor: Anchor.center,
    );
    
    // 로딩 텍스트
    final loadingText = TextComponent(
      text: 'Loading...',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2 + 40),
      anchor: Anchor.center,
    );
    
    add(titleText);
    add(loadingText);
    
    // 바로 오프닝 씬으로 이동
    timer = Timer(0.5, onTick: () {
      gameRef.navigateTo('opening');
    });
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
  }
} 