import 'package:flutter/material.dart';
import '../my_game.dart';

class GameOverlay extends StatelessWidget {
  final MyGame gameRef;

  const GameOverlay({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // 상단 정보 표시
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade300,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                gameRef.playerName.isEmpty ? '플레이어' : gameRef.playerName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
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
              const Spacer(),
              _buildStatIndicator(Icons.favorite, '행복', Colors.pink),
              const SizedBox(width: 8),
              _buildStatIndicator(Icons.restaurant, '배고픔', Colors.amber),
            ],
          ),
          
          const Spacer(),
          
          // 하단 컨트롤 버튼들
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.pets, '놀기', Colors.blue),
                _buildActionButton(Icons.restaurant, '먹이주기', Colors.orange),
                _buildActionButton(Icons.school, '공부하기', Colors.green),
                _buildActionButton(Icons.nightlight, '재우기', Colors.indigo),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatIndicator(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 4),
          Text(
            '80%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 26,
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: () {
              // 액션 수행 코드 추가
            },
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
} 