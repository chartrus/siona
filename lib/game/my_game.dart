import 'package:flame/game.dart';
import 'package:flame/components.dart';

import 'scenes/splash_scene.dart';
import 'scenes/opening_scene.dart';
import 'scenes/name_input_scene.dart';
import 'scenes/game_scene.dart';

class MyGame extends FlameGame {
  // 게임 상태 저장
  String playerName = '';
  String aiName = '';
  
  // 라우터 컴포넌트 참조 저장
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // 라우터 컴포넌트 생성 및 추가
    router = RouterComponent(
      initialRoute: 'splash',
      routes: {
        'splash': Route(SplashScene.new),
        'opening': Route(OpeningScene.new),
        'nameInput': Route(NameInputScene.new),
        'game': Route(GameScene.new),
      },
    );
    add(router);
  }
  
  // 이름 저장 메서드
  void setNames(String playerName, String aiName) {
    this.playerName = playerName;
    this.aiName = aiName;
  }
  
  // 경로 변경 메서드
  void navigateTo(String routeName) {
    router.pushNamed(routeName);
  }
} 