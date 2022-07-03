import 'package:audio_player/widgets/inner_shadow.dart';
import 'package:audio_player/widgets/play_button.dart';
import 'package:audio_player/widgets/song_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/controller/home_controller.dart';
import 'package:audio_player/models/song_model.dart';
import 'package:audio_player/profile/singer_profile.dart';
import 'package:audio_player/widgets/blur_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'bottom_sheet.dart';

class ListWidget extends StatefulWidget {
  final List<SongModel> allsongs;
  const ListWidget({Key? key, required this.allsongs}) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NowPlayingController>(
      builder: (context, controller, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.allsongs.length,
          itemBuilder: (context, i) {
            final song = widget.allsongs[i];

            return GestureDetector(
              onTap: () {
                print("pressed");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SongView(
                      controller: controller,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Color(0xFFE1E7F5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(33.0),
                          ),
                          boxShadow: [
                            const BoxShadow(
                                offset: Offset(10, 10),
                                blurRadius: 10.0,
                                color: Colors.white),
                            const BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 10.0,
                                color: Colors.white),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              // offset: Offset(5,5)// shadow color
                            ),
                            const BoxShadow(
                              offset: Offset(0, 6),
                              blurRadius: 6,
                              color: Color(0xFFE1E7F5), // background color
                            ),
                          ],
                          // boxShape: NeumorphicBoxShape.roundRect(
                          //   BorderRadius.all(
                          //     Radius.circular(33.0),
                          //   ),
                          // ),
                        ),
                        child: InnerShadow(
                          blur: 5,
                          color: Colors.black38.withOpacity(0.2),
                          offset: Offset(5, 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(33.0))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: StreamBuilder<PlayerState>(
                                      stream:
                                          controller.player.playerStateStream,
                                      builder: (context, snapshot) {
                                        final playerState = snapshot.data;
                                        final processingState =
                                            playerState?.processingState;
                                        final playing = playerState?.playing;
                                        if (processingState ==
                                                ProcessingState.loading ||
                                            processingState ==
                                                ProcessingState.buffering) {
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
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                depth: 6,
                                                lightSource:
                                                    LightSource.topLeft,
                                                shadowLightColor: Colors.white,
                                                shadowDarkColor: Colors.black54,
                                                color: Color(0xFFF5F5FA)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    //color: Colors.amber,
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
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
                                                    onTap: () async {
                                                      //isPlaying = !isPlaying;
                                                      await controller.player
                                                          .play();
                                                      //isPlaying = !isPlaying;
                                                    },
                                                    child: const Icon(
                                                      Icons.play_arrow_rounded,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else if (processingState !=
                                            ProcessingState.completed) {
                                          return Neumorphic(
                                            style: const NeumorphicStyle(
                                                intensity: 0.7,
                                                shape: NeumorphicShape.flat,
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                depth: 6,
                                                lightSource:
                                                    LightSource.topLeft,
                                                shadowLightColor: Colors.white,
                                                shadowDarkColor: Colors.black54,
                                                color: Color(0xFFF5F5FA)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      //isPlaying = !isPlaying;
                                                      await controller.player
                                                          .pause();
                                                      //isPlaying = !isPlaying;
                                                    },
                                                    child: const Icon(
                                                      Icons.pause_rounded,
                                                      color: Colors.white,
                                                      size: 30.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return IconButton(
                                            icon: const Icon(Icons.replay,
                                                color: Colors.white),
                                            onPressed: () => controller.player
                                                .seek(Duration.zero),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    song.song!,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: GoogleFonts
                                                        .sairaSemiCondensed(
                                                      color: Color(0xFF5E5E5E),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  // const SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  InkWell(
                                                    onTap: () {
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder: (context) =>
                                                      //         ArtistProfile(
                                                      //       name: song.artist!,
                                                      //       controller:
                                                      //           controller,
                                                      //     ),
                                                      //   ),
                                                      // )
                                                    },
                                                    child: Text(
                                                      song.artist!,
                                                      style: GoogleFonts
                                                          .sairaSemiCondensed(
                                                        color:
                                                            Color(0xFF7B7C81),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // showBottomSheet(
                                      //   context: context,
                                      //   builder: (context) {
                                      //     return BoottomSheet(
                                      //       controller: controller,
                                      //       song: song,
                                      //     );
                                      //   },
                                      // );
                                    },
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      color: Color(0xFF949CA7),
                                      size: 30.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white.withOpacity(.2),
                      thickness: 1.5,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
