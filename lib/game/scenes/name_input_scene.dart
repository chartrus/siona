import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../my_game.dart';

class NameInputScene extends Component with HasGameRef<MyGame> {
  // 컴포넌트 키 설정
  NameInputScene() : super(key: ComponentKey.named('nameInput'));
  
  @override
  Future<void> onLoad() async {
    // 배경 색상을 위한 RectangleComponent
    final background = RectangleComponent(
      size: gameRef.size,
      paint: Paint()..color = Colors.deepPurple.shade700,
    );
    
    // 안내 텍스트
    final guideText = TextComponent(
      text: '이름을 입력해주세요',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2 - 100),
      anchor: Anchor.center,
    );
    
    add(background);
    add(guideText);
  }
  
  @override
  void onMount() {
    super.onMount();
    // Flutter UI 오버레이 표시
    gameRef.overlays.add('nameInputOverlay');
  }
  
  @override
  void onRemove() {
    gameRef.overlays.remove('nameInputOverlay');
    super.onRemove();
  }
  
  // 이름 입력 완료 후 게임 시작
  void onNameSubmitted(String playerName, String aiName) {
    // 게임 상태에 이름 저장
    gameRef.setNames(playerName, aiName);
    
    // 게임 화면으로 이동
    gameRef.navigateTo('game');
  }
} 