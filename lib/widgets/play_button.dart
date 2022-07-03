import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';

class PlayButton extends StatelessWidget {
  final AudioPlayer player;
  const PlayButton({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return const SizedBox(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1.5,
            ),
          );
        } else if (playing != true) {
          return Neumorphic(
            style: const NeumorphicStyle(
              intensity: 0.7,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 6,
              // lightSource: LightSource.topLeft,
              // shadowLightColor: Colors.white,
              // shadowDarkColor: Colors.black54,
              // color: Color(0xFFF5F5FA),
            ),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xfff8f8f8),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0c000000),
                    blurRadius: 10,
                    offset: Offset(10, 10),
                  ),
                  BoxShadow(
                    color: Color(0xffffffff),
                    blurRadius: 15,
                    offset: Offset(-10, -10),
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  //color: Colors.amber,
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(0, 234, 255, 1),
                      Color.fromRGBO(60, 140, 231, 1),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      //isPlaying = !isPlaying;
                      await player.play();
                      //isPlaying = !isPlaying;
                    },
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 52,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (processingState != ProcessingState.completed) {
          return Neumorphic(
            style: const NeumorphicStyle(
                intensity: 0.7,
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 6,
                lightSource: LightSource.topLeft,
                shadowLightColor: Colors.white,
                shadowDarkColor: Colors.black54,
                color: Color(0xfff8f8f8)),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xfff8f8f8),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0c000000),
                    blurRadius: 10,
                    offset: Offset(10, 10),
                  ),
                  BoxShadow(
                    color: Color(0xffffffff),
                    blurRadius: 15,
                    offset: Offset(-10, -10),
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  //color: Colors.amber,
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(0, 234, 255, 1),
                      Color.fromRGBO(60, 140, 231, 1),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      //isPlaying = !isPlaying;
                      await player.pause();
                      //isPlaying = !isPlaying;
                    },
                    child: const Icon(
                      Icons.pause_rounded,
                      color: Colors.white,
                      size: 52,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay, color: Colors.white),
            onPressed: () => player.seek(Duration.zero),
          );
        }
      },
    );
  }
}

class BiggerPlayButton extends StatelessWidget {
  const BiggerPlayButton(
      {Key? key,
      required this.player,
      required this.icon,
      required this.function})
      : super(key: key);

  final AudioPlayer player;
  final IconData icon;
  final Future function;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
          intensity: 0.7,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          depth: 6,
          lightSource: LightSource.topLeft,
          shadowLightColor: Colors.white,
          shadowDarkColor: Colors.black54,
          color: Color(0xFFF5F5FA)),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xfff8f8f8),
          boxShadow: [
            BoxShadow(
              color: Color(0x0c000000),
              blurRadius: 10,
              offset: Offset(10, 10),
            ),
            BoxShadow(
              color: Color(0xffffffff),
              blurRadius: 15,
              offset: Offset(-10, -10),
            ),
          ],
        ),
        child: Container(
          decoration: const BoxDecoration(
            //color: Colors.amber,
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(0, 234, 255, 1),
                Color.fromRGBO(60, 140, 231, 1),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                //isPlaying = !isPlaying;
                await function;
                //isPlaying = !isPlaying;
              },
              child: Icon(
                icon,
                color: Colors.white,
                size: 52,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// IconButton(
// icon: const Icon(CupertinoIcons.play_arrow, color: Colors.white),
// onPressed: player.play,
// )

// Neumorphic(
// // onPressed: () => player.play(),
// style: const NeumorphicStyle(
// boxShape: NeumorphicBoxShape.circle(),
// shape: NeumorphicShape.concave,
// color: Color(0xFFF5F5FA),
// depth: 20.0,
// ),
// child: InkWell(
// onTap: () => player.play(),
// child: Container(
// padding: const EdgeInsets.all(12.0),
// child: Neumorphic(
// style: const NeumorphicStyle(
// boxShape: NeumorphicBoxShape.circle(),
// shape: NeumorphicShape.convex,
// color: Color(0xFFF5F5FA),
// depth: 5.0,
// ),
// child: InkWell(
//
// child: Container(
// decoration: const BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// colors: [
// Color.fromRGBO(0, 234, 255, 1),
// Color.fromRGBO(60, 140, 231, 1),
// ],
// ),
// ),
// child: GestureDetector(
// onTap: () => player.play,
// child: const Padding(
// padding: EdgeInsets.all(8.0),
// child: Icon(
// Icons.play_arrow_rounded,
// color: Colors.white,
// size: 56.0,
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// )
