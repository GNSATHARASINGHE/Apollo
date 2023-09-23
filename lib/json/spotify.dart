import 'package:flutter/material.dart';

class SongListPage extends StatelessWidget {
  final List<String> songs;

  SongListPage({required this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song List'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(songs[index]),
          );
        },
      ),
    );
  }
}
