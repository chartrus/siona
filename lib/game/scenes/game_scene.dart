import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../my_game.dart';

class GameScene extends Component with HasGameRef<MyGame> {
  @override
  Future<void> onLoad() async {
    // 단순한 배경 색상
    final background = RectangleComponent(
      size: gameRef.size,
      paint: Paint()..color = Colors.deepPurple.shade300,
    );
    
    // 게임 제목
    final titleText = TextComponent(
      text: 'SIONA 게임',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
      position: Vector2(gameRef.size.x / 2, 50),
      anchor: Anchor.topCenter,
    );
    
    // AI 이름 표시
    final nameText = TextComponent(
      text: '${gameRef.aiName.isEmpty ? 'AI 친구' : gameRef.aiName}와 함께하는 게임',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
      position: Vector2(gameRef.size.x / 2, 90),
      anchor: Anchor.topCenter,
    );
    
    // 플레이어 이름 표시
    final playerText = TextComponent(
      text: '플레이어: ${gameRef.playerName}',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      position: Vector2(gameRef.size.x / 2, 130),
      anchor: Anchor.topCenter,
    );
    
    add(background);
    add(titleText);
    add(nameText);
    add(playerText);
  }
  
  @override
  void onMount() {
    super.onMount();
    // 게임 UI 오버레이 표시
    gameRef.overlays.add('gameOverlay');
  }
} 