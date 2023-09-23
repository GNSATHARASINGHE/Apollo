import 'dart:io';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MusicDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final String img;
  final String songUrl;
  const MusicDetailPage(
      {super.key,
      required this.title,
      required this.description,
      required this.color,
      required this.img,
      required this.songUrl});

  @override
  State<MusicDetailPage> createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  late String artistName = '';
  late String albumArtUrl = '';

  Color primary = Colors.amber;
  final String clientId = '5d01e47fab0844c9b7f5c7ed4cf12718';
  final String clientSecret = '34fa810e6c054630939ea51cd226d2ec';

  final String authUrl = 'https://accounts.spotify.com/api/token';

//audio player here
  final advancedPlayer = AudioPlayer();
  //late AudioCache audioCache;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${Duration(seconds: seconds)}'.split('.')[0].padLeft(8, '0');
  }

  Future<void> playSong() async {
    final String trackUrl =
        'https://api.spotify.com/v1/tracks/${widget.songUrl}';
    final authResponse = await http.post(
      Uri.parse(authUrl),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode("$clientId:$clientSecret"))}',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (authResponse.statusCode == 200) {
      final Map<String, dynamic> authData = json.decode(authResponse.body);
      final String accessToken = authData['access_token'];

      final trackResponse = await http.get(
        Uri.parse(trackUrl),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (trackResponse.statusCode == 200) {
        final Map<String, dynamic> trackData = json.decode(trackResponse.body);
        final String audioUrl = trackData['preview_url'];

        try {
          await advancedPlayer.play(UrlSource(audioUrl));
        } catch (e) {
          print('Error loading song: $e');
        }
      }
    }
  }

  Future<void> fetchSongDetails() async {
    final String accessToken =
        'https://accounts.spotify.com/api/token'; // Replace with your actual access token
    final String trackUrl = 'https://api.spotify.com/v1/tracks/$widget.songUrl';

    final response = await http.get(
      Uri.parse(trackUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> trackData = json.decode(response.body);

      setState(() {
        artistName = trackData['artists'][0]['name'];
        albumArtUrl = trackData['album']['images'][0]['url'];
      });
    } else {
      print('Error fetching song details: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    advancedPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    advancedPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    advancedPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    playSong();
    fetchSongDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      actions: const [
        IconButton(
            onPressed: null,
            icon: Icon(FeatherIcons.moreVertical, color: Colors.white))
      ],
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 0,
              ),
              child: Container(
                width: size.width - 20,
                height: size.width - 60,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: widget.color,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(-10, 30))
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.img), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: size.width - 60,
                height: size.width - 60,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Container(
            width: size.width - 80,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  //AntIcons.folderAddOutlined,
                  EvaIcons.folderAdd,
                  color: Colors.white,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        widget.description,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  //AntIcons.folderAddOutlined,
                  FeatherIcons.moreVertical,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: StreamBuilder(
              stream: advancedPlayer.onPositionChanged,
              builder: (context, snapshot) {
                print(snapshot.data);
                return ProgressBar(
                  progress: snapshot.data ?? const Duration(seconds: 0),
                  total: duration,
                  thumbColor: primary,
                  bufferedBarColor: primary,
                  thumbGlowColor: primary.withOpacity(0.8),
                  progressBarColor: primary,
                  onSeek: (position) {
                    advancedPlayer.seek(position);
                    setState(() {});
                  },
                );
              }),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatTime(position.inSeconds),
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
              Text(
                formatTime((duration - position).inSeconds),
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  FeatherIcons.shuffle,
                  color: Colors.white.withOpacity(0.8),
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {
                  //advancedPlayer.play(AssetSource('audio/Salli.mp3'));
                  //advancedPlayer.play(AssetSource(widget.songUrl));
                },
                icon: Icon(
                  FeatherIcons.skipBack,
                  color: Colors.white.withOpacity(0.8),
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await advancedPlayer.pause();

                    //

                    //playSound(widget.songUrl);
                  } else {
                    //
                    await advancedPlayer.resume();

                    //stopSound(widget.songUrl);
                  }
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                iconSize: 50,
                icon: Container(
                  decoration:
                      BoxDecoration(color: primary, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      isPlaying
                          ? Entypo.controller_paus
                          : Entypo.controller_play,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(
                  FeatherIcons.skipForward,
                  color: Colors.white.withOpacity(0.8),
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(
                  AntIcons.retweetOutlined,
                  color: Colors.white.withOpacity(0.8),
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.tv,
              color: primary,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                "Chromecast is ready",
                style: TextStyle(color: primary),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
