import 'package:audio_player/animations/fade_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:audio_player/widgets/favorite_bottomsheet.dart';
import 'package:audio_player/widgets/new_songs_page_carousol.dart';
import 'package:audio_player/widgets/sidebar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:audio_player/controller/home_controller.dart';
import 'package:audio_player/data/songs_data.dart';
import 'package:audio_player/models/song_model.dart';
import 'package:audio_player/search/search_page.dart';
import 'package:audio_player/widgets/blur_container.dart';
import 'package:audio_player/widgets/horizontal_list.dart';
import 'package:audio_player/widgets/list_widget.dart';
import 'package:audio_player/widgets/song_banner.dart';
import 'package:audio_player/widgets/song_view.dart';

import 'onboarding/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('Name');
  await Hive.openBox('Favorite');
  await Hive.openBox('AllPlaylist');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('Name');
    final name = box.get(1);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: ChangeNotifierProvider(
        create: (context) => NowPlayingController()..init(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  // final String name;
  final NowPlayingController controller = NowPlayingController();
  HomePage({
    Key? key,
    // required this.name,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<SongModel> allsongs =
        songs.map((e) => SongModel.fromJson(e)).toList();

    return Consumer<NowPlayingController>(
      builder: (context, controller, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            backgroundColor: const Color(0xFFF5F5FA),
            body: Stack(
              children: [
                AnimatedPositioned(
                  top: 0,
                  left: isShow ? size.width * 0.7 : 0,
                  width: size.width,
                  height: size.height,
                  duration: const Duration(microseconds: 500),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        height: size.height,
                        child: Container(
                          width: size.width,
                          height: size.height,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5F5FA),
                          ),
                          child: BlurryContainer(
                            bgColor: Color(0xFFF5F5FA),
                            blur: 50,
                            child: SafeArea(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 100),

                                    ListWidget(
                                      allsongs: allsongs,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        height: 120,
                        child: SafeArea(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   isShow = !isShow;
                                    // });
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: Color.fromRGBO(46, 49, 55, 1),
                                  ),
                                ),
                                Spacer(),
                                Text("My Song List", style: GoogleFonts.sairaSemiCondensed(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w600,
                                ),),
                                Spacer(),
                                InkWell(
                                  onTap: (){},
                                  child: Neumorphic(
                                    style: const NeumorphicStyle(
                                      boxShape: NeumorphicBoxShape.circle(),
                                      shape: NeumorphicShape.convex,
                                      color: Color(0xFFF5F5FA),
                                      depth: 5.0,
                                    ),
                                    child: Container(
                                      height: 50.0,
                                      width: 50.0,
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
                                          padding: EdgeInsets.all(4.0),
                                          child: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                return ui.Gradient.linear(
                                                  Offset(4.0, 24.0),
                                                  Offset(24.0, 4.0),
                                                  [
                                                    const Color.fromRGBO(
                                                        60, 140, 231, 1),
                                                    const Color.fromRGBO(
                                                        0, 234, 255, 1),
                                                    // Colors.blue[200]!,
                                                    // Colors.greenAccent,
                                                  ],
                                                );
                                              },
                                              child: Icon(Icons
                                                  .search))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // AnimatedPositioned(
                      //   duration: const Duration(microseconds: 500),
                      //   bottom: 0,
                      //   left: 0,
                      //   right: 0,
                      //   height: 95,
                      //   child: GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => SongView(
                      //               controller: controller,
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //       child: SongBanner(
                      //         player: controller.player,
                      //         controller: controller,
                      //       )),
                      // ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  top: 0,
                  duration: const Duration(microseconds: 500),
                  left: isShow ? 0 : size.width,
                  height: size.height,
                  width: size.width * 0.7,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    child: SideBar(size: size, controller: controller),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
