import 'package:flame/components.dart';
import 'package:flame/input.dart';
import '../data/soul_state.dart';

class SoulCharacter extends PositionComponent with KeyboardHandler {
  final SoulState state;
  Vector2 velocity = Vector2.zero();
  static const double speed = 200.0;

  SoulCharacter({
    required Vector2 position,
    required Vector2 size,
    SoulState? state,
  }) : state = state ?? SoulState(),
       super(position: position, size: size);

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    velocity = Vector2.zero();

    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      velocity.x = -speed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      velocity.x = speed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      velocity.y = -speed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      velocity.y = speed;
    }

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    state.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // 영혼의 색상을 정화도에 따라 변경
    final paint = Paint()
      ..color = Color.lerp(
        Colors.black,
        Colors.white,
        state.purificationLevel,
      )!;

    // 간단한 원형으로 영혼 표현
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paint,
    );
  }
} 