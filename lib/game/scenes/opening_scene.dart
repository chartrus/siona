import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import '../my_game.dart';

class OpeningScene extends Component with HasGameRef<MyGame> {
  late final Timer sceneTimer;
  
  @override
  Future<void> onLoad() async {
    // 간단한 텍스트만 표시
    final welcomeText = TextComponent(
      text: '당신의 AI 친구를 만나볼 시간입니다',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2),
      anchor: Anchor.center,
    );
    
    add(welcomeText);
    
    // 5초 후 이름 입력 화면으로 이동
    sceneTimer = Timer(5, onTick: () {
      gameRef.navigateTo('nameInput');
    });
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    sceneTimer.update(dt);
  }
} 