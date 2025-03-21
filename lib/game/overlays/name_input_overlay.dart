import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../scenes/name_input_scene.dart';
import '../my_game.dart';

class NameInputOverlay extends StatefulWidget {
  final MyGame gameRef;
  
  const NameInputOverlay({super.key, required this.gameRef});
  
  @override
  State<NameInputOverlay> createState() => _NameInputOverlayState();
}

class _NameInputOverlayState extends State<NameInputOverlay> {
  final TextEditingController _playerNameController = TextEditingController();
  final TextEditingController _aiNameController = TextEditingController();
  
  @override
  void dispose() {
    _playerNameController.dispose();
    _aiNameController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _playerNameController,
              decoration: const InputDecoration(
                labelText: '당신의 이름',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _aiNameController,
              decoration: const InputDecoration(
                labelText: 'AI 친구의 이름',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final playerName = _playerNameController.text.trim();
                final aiName = _aiNameController.text.trim();
                
                if (playerName.isNotEmpty && aiName.isNotEmpty) {
                  // 이름 입력 씬에 전달
                  final nameInputScene = widget.gameRef.findByKeyName('nameInput') as NameInputScene?;
                  if (nameInputScene != null) {
                    nameInputScene.onNameSubmitted(playerName, aiName);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              ),
              child: const Text(
                '게임 시작하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 