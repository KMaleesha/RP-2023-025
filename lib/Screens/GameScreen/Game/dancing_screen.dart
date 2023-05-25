// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flame/components.dart';
// import 'package:flame/flame.dart';
// import 'package:flame/game.dart';
// import 'package:flame/sprite.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class GameScreen extends StatefulWidget {
//   const GameScreen({Key? key}) : super(key: key);
//
//   @override
//   State<GameScreen> createState() => _GameScreenState();
// }
//
// class _GameScreenState extends State<GameScreen> {
//   @override
//   void initState() {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
//     super.initState();
//   }
//
//   late double width, height;
//
//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.width;
//     height = MediaQuery.of(context).size.height;
//     Size screenSize = MediaQuery.of(context).size;
//     double aspectRatio = screenSize.height / screenSize.width;
//     return Scaffold(
//       backgroundColor: Colors.amber,
//       body: AspectRatio(
//         aspectRatio: aspectRatio,
//         child: GameWidget(
//           game: Game(context, screenSize),
//         ),
//       ),
//     );
//   }
// }
//
// class Game extends FlameGame {
//   BuildContext context;
//   Size screenSize;
//
//   Game(this.context, this.screenSize);
//
//   SpriteAnimationComponent animationComponent1 =
//   SpriteAnimationComponent(size: Vector2(840, 300));
//
//   @override
//   Color backgroundColor() => const Color(0xFFFFC107);
//
//   @override
//   Future<void>? onLoad() async {
//     super.onLoad();
//     await loadAnimations();
//     add(animationComponent1);
//     animationComponent1.position = Vector2(
//       screenSize.width / 2 - animationComponent1.size.x / 2,
//       screenSize.height / 2 - animationComponent1.size.y / 2,
//     );
//   }
//
//   Future<void> loadAnimations() async {
//     ByteData spriteSheetData =
//     await rootBundle.load('assets/gameAssets/spritesheet.png');
//     Uint8List spriteSheetBytes = spriteSheetData.buffer.asUint8List();
//
//     Image spriteSheetImage = await decodeImageFromList(spriteSheetBytes);
//
//     SpriteSheet spriteSheet = SpriteSheet(
//       image: spriteSheetImage,
//       srcSize: Vector2(1226, 1226),
//     );
//
//     SpriteAnimation spriteAnimation =
//     spriteSheet.createAnimation(row: 0, stepTime: 0.9, from: 5, to: 24);
//
//     animationComponent1.animation = spriteAnimation;
//   }
// }
