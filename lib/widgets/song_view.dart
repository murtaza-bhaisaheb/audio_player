import 'package:audio_player/widgets/clip_shadow_path.dart';
import 'package:audio_player/widgets/clipper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_player/animations/fade_animation.dart';
import 'package:audio_player/controller/home_controller.dart';
import 'package:audio_player/models/song_model.dart';
import 'package:audio_player/profile/singer_profile.dart';
import 'package:audio_player/widgets/play_button.dart';
import 'package:audio_player/widgets/seekbar.dart';
import 'dart:ui' as ui;

class SongView extends StatefulWidget {
  final NowPlayingController controller;
  const SongView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Color(0xFFF0F1F6),
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 80.0,
          backgroundColor: Color(0xFFF0F1F6),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Neumorphic(
                      style: const NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.convex,
                        color: Color(0xFFF5F5FA),
                        depth: 5.0,
                      ),
                      child: Container(
                        height: 35.0,
                        width: 35.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF5F5FA),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              offset: Offset(-5.0, 10.0),
                            ),
                            BoxShadow(
                              color: Color.fromRGBO(170, 170, 204, 0.25),
                              offset: Offset(15.0, 20.0),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.share,
                            size: 16.0,
                            color: Color.fromRGBO(199, 197, 208, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Neumorphic(
                      style: const NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.convex,
                        color: Color(0xFFF5F5FA),
                        depth: 5.0,
                      ),
                      child: Container(
                        height: screenHeight / 8,
                        width: screenWidth / 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF5F5FA),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              offset: Offset(-5.0, 10.0),
                            ),
                            BoxShadow(
                              color: Color.fromRGBO(170, 170, 204, 0.25),
                              offset: Offset(15.0, 20.0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return ui.Gradient.linear(
                                const Offset(4.0, 24.0),
                                const Offset(24.0, 4.0),
                                [
                                  const Color.fromRGBO(60, 140, 231, 1),
                                  const Color.fromRGBO(0, 234, 255, 1),
                                  // Colors.blue[200]!,
                                  // Colors.greenAccent,
                                ],
                              );
                            },
                            child: const Icon(
                              Icons.favorite_border_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        body: StreamBuilder<SequenceState?>(
            stream: widget.controller.player.sequenceStateStream,
            builder: (context, snapshot) {
              final state = snapshot.data;
              if (state?.sequence.isEmpty ?? true) return const SizedBox();
              final metadata = state!.currentSource!.tag as SongModel;
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F1F6),
                ),
                child: SingleChildScrollView(
                      // physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const SizedBox(height: 140),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    (322 / 837),
                                child: ClipShadowPath(
                                  shadow: const BoxShadow(
                                      color: Color(0xffA6ABBD),
                                      spreadRadius: 12,
                                      blurRadius: 5,
                                      offset: Offset(9, 12)),
                                  clipper: BigClipper(),
                                  child: Container(
                                    color: const Color(0xffF0F1F6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipPath(
                                        clipper: BigClipper(),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    AssetImage('images/1.png'),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SlideAnimation(
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => ArtistProfile(
                                        //       name: metadata.artist!,
                                        //       controller: widget.controller,
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                      child: Text(metadata.artist!,
                                          style: GoogleFonts.sairaSemiCondensed(
                                            fontSize: 20.0,
                                            color: const Color.fromRGBO(
                                                123, 124, 129, 1),
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ),
                                  SlideAnimation(
                                    Text(
                                      metadata.song!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.sairaSemiCondensed(
                                        color:
                                            const Color.fromRGBO(94, 94, 94, 1),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 3.0,
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 0.0, 8.0, 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      StreamBuilder<LoopMode>(
                                          stream: widget
                                              .controller.player.loopModeStream,
                                          builder: (context, snapshot) {
                                            final loopMode =
                                                snapshot.data ?? LoopMode.off;
                                            const cycleModes = [
                                              LoopMode.off,
                                              LoopMode.all,
                                              LoopMode.one,
                                            ];
                                            final index =
                                                cycleModes.indexOf(loopMode);
                                            return InkWell(
                                              onTap: () {
                                                widget.controller.player
                                                    .setLoopMode(cycleModes[
                                                        (cycleModes.indexOf(
                                                                    loopMode) +
                                                                1) %
                                                            cycleModes.length]);
                                              },
                                              child: Neumorphic(
                                                style: const NeumorphicStyle(
                                                  boxShape: NeumorphicBoxShape
                                                      .circle(),
                                                  shape: NeumorphicShape.convex,
                                                  color: Color(0xFFF5F5FA),
                                                  depth: 5.0,
                                                ),
                                                child: Container(
                                                  height: 35.0,
                                                  width: 35.0,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xFFF5F5FA),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 0.5),
                                                        offset:
                                                            Offset(-5.0, 10.0),
                                                      ),
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            170,
                                                            170,
                                                            204,
                                                            0.25),
                                                        offset:
                                                            Offset(15.0, 20.0),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Image.asset(
                                                        'assets/images/repeat.png'),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Neumorphic(
                                          style: const NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.circle(),
                                            shape: NeumorphicShape.convex,
                                            color: Color(0xFFF5F5FA),
                                            depth: 5.0,
                                          ),
                                          child: Container(
                                            height: 35.0,
                                            width: 35.0,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFF5F5FA),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.5),
                                                  offset: Offset(-5.0, 10.0),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      170, 170, 204, 0.25),
                                                  offset: Offset(15.0, 20.0),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Image.asset(
                                                  'assets/images/library.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Neumorphic(
                                          style: const NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.circle(),
                                            shape: NeumorphicShape.convex,
                                            color: Color(0xFFF5F5FA),
                                            depth: 5.0,
                                          ),
                                          child: Container(
                                            height: 35.0,
                                            width: 35.0,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFF5F5FA),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.5),
                                                  offset: Offset(-5.0, 10.0),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      170, 170, 204, 0.25),
                                                  offset: Offset(15.0, 20.0),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                  'assets/images/playlist_add.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Neumorphic(
                                          style: const NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.circle(),
                                            shape: NeumorphicShape.convex,
                                            color: Color(0xFFF5F5FA),
                                            depth: 5.0,
                                          ),
                                          child: Container(
                                            height: 35.0,
                                            width: 35.0,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFF5F5FA),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.5),
                                                  offset: Offset(-5.0, 10.0),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      170, 170, 204, 0.25),
                                                  offset: Offset(15.0, 20.0),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Image.asset(
                                                  'assets/images/settings.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            SlideAnimation(
                              StreamBuilder<PositionData>(
                                stream: widget.controller.positionDataStream,
                                builder: (context, snapshot) {
                                  final positionData = snapshot.data;
                                  return SeekBar(
                                    duration:
                                        positionData?.duration ?? Duration.zero,
                                    position:
                                        positionData?.position ?? Duration.zero,
                                    bufferedPosition:
                                        positionData?.bufferedPosition ??
                                            Duration.zero,
                                    onChangeEnd: widget.controller.player.seek,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SlideAnimation(
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(.2),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // IconButton(
                                        //   icon: Icon(
                                        //     Icons.volume_up,
                                        //     color: Colors.white.withOpacity(.6),
                                        //   ),
                                        //   onPressed: () {
                                        //     showSliderDialog(
                                        //       context: context,
                                        //       title: "Adjust volume",
                                        //       divisions: 10,
                                        //       min: 0.0,
                                        //       max: 1.0,
                                        //       value: widget
                                        //           .controller.player.volume,
                                        //       stream: widget.controller.player
                                        //           .volumeStream,
                                        //       onChanged: widget
                                        //           .controller.player.setVolume,
                                        //     );
                                        //   },
                                        // ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     if (widget.controller.player
                                        //         .hasPrevious) {
                                        //       widget.controller.player
                                        //           .seekToPrevious();
                                        //       widget.controller.player.play();
                                        //     }
                                        //   },
                                        //   icon: const Icon(
                                        //     CupertinoIcons.backward_end,
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
                                        Neumorphic(
                                          style: const NeumorphicStyle(
                                              intensity: 0.7,
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
                                              depth: 6,
                                              lightSource: LightSource.topLeft,
                                              shadowLightColor: Colors.white,
                                              shadowDarkColor: Colors.black54,
                                              color: Color(0xFFF5F5FA)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  //color: Colors.amber,
                                                  shape: BoxShape.circle,
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          0, 234, 255, 1),
                                                      Color.fromRGBO(
                                                          60, 140, 231, 1),
                                                    ],
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (widget.controller.player
                                                        .hasPrevious) {
                                                      widget.controller.player
                                                          .seekToPrevious();
                                                      widget.controller.player
                                                          .play();
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons
                                                        .navigate_before_rounded,
                                                    color: Colors.white,
                                                    size: 36,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        PlayButton(
                                          player: widget.controller.player,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Neumorphic(
                                          style: const NeumorphicStyle(
                                              intensity: 0.7,
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
                                              depth: 6,
                                              lightSource: LightSource.topLeft,
                                              shadowLightColor: Colors.white,
                                              shadowDarkColor: Colors.black54,
                                              color: Color(0xFFF5F5FA)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  //color: Colors.amber,
                                                  shape: BoxShape.circle,
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          0, 234, 255, 1),
                                                      Color.fromRGBO(
                                                          60, 140, 231, 1),
                                                    ],
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (widget.controller.player
                                                        .hasNext) {
                                                      widget.controller.player
                                                          .seekToNext();
                                                      widget.controller.player
                                                          .play();
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.navigate_next_rounded,
                                                    color: Colors.white,
                                                    size: 36,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     if (widget
                                        //         .controller.player.hasNext) {
                                        //       widget.controller.player
                                        //           .seekToNext();
                                        //       widget.controller.player.play();
                                        //     }
                                        //   },
                                        //   icon: const Icon(
                                        //     CupertinoIcons.forward_end,
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        // StreamBuilder<double>(
                                        //   stream: widget
                                        //       .controller.player.speedStream,
                                        //   builder: (context, snapshot) =>
                                        //       IconButton(
                                        //     icon: Text(
                                        //       "${snapshot.data?.toStringAsFixed(1)}x",
                                        //       style: TextStyle(
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Colors.white
                                        //             .withOpacity(.6),
                                        //       ),
                                        //     ),
                                        //     onPressed: () {
                                        //       showSliderDialog(
                                        //         context: context,
                                        //         title: "Adjust speed",
                                        //         divisions: 10,
                                        //         min: 0.5,
                                        //         max: 1.5,
                                        //         value: widget
                                        //             .controller.player.speed,
                                        //         stream: widget.controller.player
                                        //             .speedStream,
                                        //         onChanged: widget
                                        //             .controller.player.setSpeed,
                                        //       );
                                        //     },
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(12.0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       StreamBuilder<bool>(
                            //         stream: widget.controller.player
                            //             .shuffleModeEnabledStream,
                            //         builder: (context, snapshot) {
                            //           final shuffleModeEnabled =
                            //               snapshot.data ?? false;
                            //           return IconButton(
                            //             icon: shuffleModeEnabled
                            //                 ? const Icon(Icons.shuffle,
                            //                     color: Colors.orange)
                            //                 : const Icon(Icons.shuffle,
                            //                     color: Colors.grey),
                            //             onPressed: () async {
                            //               final enable = !shuffleModeEnabled;
                            //               if (enable) {
                            //                 await widget.controller.player
                            //                     .shuffle();
                            //               }
                            //               await widget.controller.player
                            //                   .setShuffleModeEnabled(enable);
                            //             },
                            //           );
                            //         },
                            //       ),
                            //       StreamBuilder<LoopMode>(
                            //         stream:
                            //             widget.controller.player.loopModeStream,
                            //         builder: (context, snapshot) {
                            //           final loopMode =
                            //               snapshot.data ?? LoopMode.off;
                            //           const icons = [
                            //             Icon(Icons.repeat, color: Colors.grey),
                            //             Icon(Icons.repeat,
                            //                 color: Colors.orange),
                            //             Icon(Icons.repeat_one,
                            //                 color: Colors.orange),
                            //           ];
                            //           const cycleModes = [
                            //             LoopMode.off,
                            //             LoopMode.all,
                            //             LoopMode.one,
                            //           ];
                            //           final index =
                            //               cycleModes.indexOf(loopMode);
                            //           return IconButton(
                            //             icon: icons[index],
                            //             onPressed: () {
                            //               widget.controller.player.setLoopMode(
                            //                   cycleModes[(cycleModes
                            //                               .indexOf(loopMode) +
                            //                           1) %
                            //                       cycleModes.length]);
                            //             },
                            //           );
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 26.0),
                            //   child: Text(
                            //     "In the Queue",
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 18,
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 20),
                            // SlideAnimation(
                            //   Container(
                            //     padding:
                            //         const EdgeInsets.symmetric(horizontal: 5.0),
                            //     child: StreamBuilder<SequenceState?>(
                            //       stream: widget
                            //           .controller.player.sequenceStateStream,
                            //       builder: (context, snapshot) {
                            //         final state = snapshot.data;
                            //         final sequence = state?.sequence ?? [];
                            //         return Theme(
                            //           data: ThemeData(
                            //             canvasColor: Colors.transparent,
                            //             shadowColor: Colors.transparent,
                            //           ),
                            //           child: ReorderableListView(
                            //             physics:
                            //                 const NeverScrollableScrollPhysics(),
                            //             shrinkWrap: true,
                            //             onReorder:
                            //                 (int oldIndex, int newIndex) {
                            //               if (oldIndex < newIndex) newIndex--;
                            //               widget.controller.playlist
                            //                   .move(oldIndex, newIndex);
                            //             },
                            //             children: [
                            //               for (var i = 0;
                            //                   i < sequence.length;
                            //                   i++)
                            //                 Padding(
                            //                   key: ValueKey(sequence[i]),
                            //                   padding:
                            //                       const EdgeInsets.all(4.0),
                            //                   child: ClipRRect(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10),
                            //                     child: ClipRRect(
                            //                       borderRadius:
                            //                           BorderRadius.circular(10),
                            //                       child: BlurryContainer(
                            //                         bgColor: Colors.black,
                            //                         blur: 10,
                            //                         child: Dismissible(
                            //                           key:
                            //                               ValueKey(sequence[i]),
                            //                           background: Container(
                            //                             color: Colors.redAccent,
                            //                             alignment: Alignment
                            //                                 .centerRight,
                            //                             child: const Padding(
                            //                               padding:
                            //                                   EdgeInsets.only(
                            //                                       right: 8.0),
                            //                               child: Icon(
                            //                                   Icons.delete,
                            //                                   color:
                            //                                       Colors.white),
                            //                             ),
                            //                           ),
                            //                           onDismissed:
                            //                               (dismissDirection) {
                            //                             widget
                            //                                 .controller.playlist
                            //                                 .removeAt(i);
                            //                           },
                            //                           child: ListTile(
                            //                             title: Text(
                            //                               sequence[i].tag.song
                            //                                   as String,
                            //                               maxLines: 2,
                            //                               overflow: TextOverflow
                            //                                   .ellipsis,
                            //                               style: TextStyle(
                            //                                 color: i ==
                            //                                         state!
                            //                                             .currentIndex
                            //                                     ? Colors.green
                            //                                     : Colors.white,
                            //                               ),
                            //                             ),
                            //                             subtitle: Text(
                            //                               sequence[i].tag.artist
                            //                                   as String,
                            //                               style: TextStyle(
                            //                                 color: Colors.white
                            //                                     .withOpacity(
                            //                                         .4),
                            //                               ),
                            //                             ),
                            //                             trailing: const Icon(
                            //                                 Icons
                            //                                     .dehaze_rounded,
                            //                                 color: Colors.white,
                            //                                 size: 20),
                            //                             onTap: () {
                            //                               widget
                            //                                   .controller.player
                            //                                   .seek(
                            //                                       Duration.zero,
                            //                                       index: i);
                            //                               widget
                            //                                   .controller.player
                            //                                   .play();
                            //                             },
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //             ],
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // SafeArea(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(10.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         IconButton(
                    //           icon: const Icon(
                    //             CupertinoIcons.back,
                    //             color: Color.fromRGBO(45, 49, 55, 1),
                    //           ),
                    //           onPressed: () => Navigator.pop(context),
                    //         ),
                    //         Row(
                    //           children: [
                    //             InkWell(
                    //               onTap: () {},
                    //               child: Neumorphic(
                    //                 style: const NeumorphicStyle(
                    //                   boxShape: NeumorphicBoxShape.circle(),
                    //                   shape: NeumorphicShape.convex,
                    //                   color: Color(0xFFF5F5FA),
                    //                   depth: 5.0,
                    //                 ),
                    //                 child: Container(
                    //                   height: 35.0,
                    //                   width: 35.0,
                    //                   decoration: const BoxDecoration(
                    //                     shape: BoxShape.circle,
                    //                     color: Color(0xFFF5F5FA),
                    //                     boxShadow: [
                    //                       BoxShadow(
                    //                         color: Color.fromRGBO(
                    //                             255, 255, 255, 0.5),
                    //                         offset: Offset(-5.0, 10.0),
                    //                       ),
                    //                       BoxShadow(
                    //                         color: Color.fromRGBO(
                    //                             170, 170, 204, 0.25),
                    //                         offset: Offset(15.0, 20.0),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   child: const Padding(
                    //                     padding: EdgeInsets.all(4.0),
                    //                     child: Icon(
                    //                       Icons.share,
                    //                       size: 16.0,
                    //                       color:
                    //                           Color.fromRGBO(199, 197, 208, 1),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 20.0,
                    //             ),
                    //             ValueListenableBuilder<Box>(
                    //               valueListenable:
                    //                   Hive.box("Favorite").listenable(),
                    //               builder: (context, box, child) {
                    //                 bool isfavorite =
                    //                     box.containsKey(metadata.song);
                    //                 if (isfavorite) {
                    //                   return IconButton(
                    //                     onPressed: () {
                    //                       final box = Hive.box("Favorite");
                    //                       box.delete(metadata.song);
                    //                     },
                    //                     icon: const Icon(
                    //                       CupertinoIcons.heart_fill,
                    //                       color: Colors.green,
                    //                     ),
                    //                   );
                    //                 } else {
                    //                   return InkWell(
                    //                     onTap: () {},
                    //                     child: Neumorphic(
                    //                       style: const NeumorphicStyle(
                    //                         boxShape:
                    //                             NeumorphicBoxShape.circle(),
                    //                         shape: NeumorphicShape.convex,
                    //                         color: Color(0xFFF5F5FA),
                    //                         depth: 5.0,
                    //                       ),
                    //                       child: Container(
                    //                         height: screenHeight / 8,
                    //                         width: screenWidth / 8,
                    //                         decoration: const BoxDecoration(
                    //                           shape: BoxShape.circle,
                    //                           color: Color(0xFFF5F5FA),
                    //                           boxShadow: [
                    //                             BoxShadow(
                    //                               color: Color.fromRGBO(
                    //                                   255, 255, 255, 0.5),
                    //                               offset: Offset(-5.0, 10.0),
                    //                             ),
                    //                             BoxShadow(
                    //                               color: Color.fromRGBO(
                    //                                   170, 170, 204, 0.25),
                    //                               offset: Offset(15.0, 20.0),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                         child: Padding(
                    //                           padding:
                    //                               const EdgeInsets.all(4.0),
                    //                           child: ShaderMask(
                    //                             blendMode: BlendMode.srcIn,
                    //                             shaderCallback: (Rect bounds) {
                    //                               return ui.Gradient.linear(
                    //                                 const Offset(4.0, 24.0),
                    //                                 const Offset(24.0, 4.0),
                    //                                 [
                    //                                   const Color.fromRGBO(
                    //                                       60, 140, 231, 1),
                    //                                   const Color.fromRGBO(
                    //                                       0, 234, 255, 1),
                    //                                   // Colors.blue[200]!,
                    //                                   // Colors.greenAccent,
                    //                                 ],
                    //                               );
                    //                             },
                    //                             child: const Icon(
                    //                               Icons.favorite_border_rounded,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   );
                    //                 }
                    //               },
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

              );
            }),
      ),
    );
  }
}

// onPressed: () {
// final box = Hive.box("Favorite");
// box.delete(metadata.song);
// },
