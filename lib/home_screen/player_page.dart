import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlayerPage extends StatefulWidget {
  final String resultType;
  final String resultId;

  PlayerPage({required this.resultType, required this.resultId});

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late AudioPlayer _audioPlayer;
  PlayerState _playerState = PlayerState.stopped;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
    playTrack();
  }

  Future<void> playTrack() async {
    final String clientId = '5d01e47fab0844c9b7f5c7ed4cf12718';
    final String clientSecret = '34fa810e6c054630939ea51cd226d2ec';
    final String authUrl = 'https://accounts.spotify.com/api/token';

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

      final String trackUrl =
          'https://api.spotify.com/v1/${widget.resultType}s/${widget.resultId}';

      final trackResponse = await http.get(
        Uri.parse(trackUrl),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (trackResponse.statusCode == 200) {
        final Map<String, dynamic> trackData = json.decode(trackResponse.body);
        final String audioUrl = trackData['preview_url'];

        if (audioUrl != null) {
          await _audioPlayer.play(UrlSource(audioUrl));
        }
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Playing Track',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          IconButton(
            icon: Icon(
              _playerState == PlayerState.playing
                  ? Icons.pause
                  : Icons.play_arrow,
              size: 36,
            ),
            onPressed: () {
              if (_playerState == PlayerState.playing) {
                _audioPlayer.pause();
              } else {
                _audioPlayer.resume();
              }
            },
          ),
        ],
      ),
    );
  }
}
