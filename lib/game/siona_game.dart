import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import '../components/soul_character.dart';
import '../data/soul_state.dart';
import 'package:flutter/material.dart';
import 'world_state.dart';
import '../overlays/rain_overlay.dart';
import '../overlays/snow_overlay.dart';
import '../overlays/lighting_overlay.dart';

class SionaGame extends FlameGame {
  late WorldState worldState;
  late AnimationController _controller;
  late Animation<double> _animation;
  late TiledComponent worldMap;
  late SoulCharacter soul;
  late SoulState soulState;

  @override
  Future<void> onLoad() async {
    worldState = WorldState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _animation.addListener(() {
      worldState.updateTime(const Duration(seconds: 1));
      worldState.updateWeather();
    });

    // Load the world map
    worldMap = await TiledComponent.load(
      'world_map.tmx',
      Vector2.all(16),
    );
    add(worldMap);

    // Initialize soul state
    soulState = SoulState();

    // Create and add the soul character
    soul = SoulCharacter(
      position: Vector2(100, 100),
      size: Vector2.all(32),
    );
    add(soul);

    // Set up camera
    camera.viewfinder.zoom = 0.5;
    camera.follow(soul);
  }

  @override
  void update(double dt) {
    super.update(dt);
    soul.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // 게임 렌더링
  }
}

class SionaGameWidget extends StatelessWidget {
  const SionaGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 게임 메인 컨텐츠
          GameWidget(
            game: SionaGame(),
          ),
          // 오버레이 효과들
          ValueListenableBuilder(
            valueListenable: WorldState(),
            builder: (context, worldState, child) {
              return Stack(
                children: [
                  LightingOverlay(
                    ambientLight: worldState.ambientLight,
                    skyColor: worldState.skyColor,
                  ),
                  if (worldState.isRaining)
                    RainOverlay(intensity: worldState.rainIntensity),
                  if (worldState.isSnowing)
                    SnowOverlay(intensity: worldState.snowIntensity),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
} 