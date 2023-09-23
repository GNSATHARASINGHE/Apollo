import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final String playlistName;
  final List<Map<String, dynamic>> playlistTracks;

  PlaylistDetailScreen(
      {required this.playlistName, required this.playlistTracks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlistName),
      ),
      body: YourTrackListWidgetHere(playlistTracks: playlistTracks),
    );
  }
}

class YourTrackListWidgetHere extends StatelessWidget {
  final List<Map<String, dynamic>> playlistTracks;

  YourTrackListWidgetHere({required this.playlistTracks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playlistTracks.length,
      itemBuilder: (context, index) {
        final track = playlistTracks[index];
        return ListTile(
          leading: Image.network(track['albumArtUrl']),
          title: Text(track['name']),
          subtitle: Text(track['artist']),
          trailing: YourPlayPauseButtonHere(audioUrl: track['audioUrl']),
        );
      },
    );
  }
}

class YourPlayPauseButtonHere extends StatefulWidget {
  final String audioUrl;

  YourPlayPauseButtonHere({required this.audioUrl});

  @override
  _YourPlayPauseButtonHereState createState() =>
      _YourPlayPauseButtonHereState();
}

class _YourPlayPauseButtonHereState extends State<YourPlayPauseButtonHere> {
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
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPause() async {
    if (_playerState == PlayerState.playing) {
      await _audioPlayer.pause();
    } else {
      // await _audioPlayer.play(UrlSource(widget.audioUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _playerState == PlayerState.playing ? Icons.pause : Icons.play_arrow,
      ),
      onPressed: widget.audioUrl.isNotEmpty ? _playPause : null,
    );
  }
}
