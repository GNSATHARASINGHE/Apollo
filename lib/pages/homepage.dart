import 'package:apollodemo1/home_screen/home_page.dart';
import 'package:apollodemo1/json/spotify.dart';
import 'package:apollodemo1/model/song_data_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  String selectedMood = '';
  List<String> spotifyTrackIds = [];
  List<SongData> songDatas = [];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    intiializeSongs();
    // Load the CSV data when the widget initializes
  }

  void intiializeSongs() async {
    List<SongData> songList =
        await readAndParseJsonAsset("assets/csvjson.json");
    print("${songList?[0].mood}");
  }

  Future<List<SongData>> readAndParseJsonAsset(String assetPath) async {
    try {
      String content = await rootBundle.loadString(assetPath);
      List<dynamic> jsonList = json.decode(content);

      // Create a list of SongData objects
      List<SongData> songList =
          jsonList.map((json) => SongData.fromJson(json)).toList();

      return songList;
    } catch (e) {
      throw Exception("Error reading and parsing JSON asset: $e");
    }
  }

  Map<String, List<String>> moodToIdsMap = {};

  Future<void> fetchSpotifyTrackIds(String mood) async {
    // Check if the mood is in the mood-to-ids map
    if (moodToIdsMap.containsKey(mood)) {
      // Fetch Spotify track IDs associated with the selected mood
      final spotifyIds = moodToIdsMap[mood]!;
      // Display the fetched Spotify track IDs
      setState(() {
        selectedMood = mood;
        spotifyTrackIds = spotifyIds;
      });
    }
  }

  Future<String> getAccessToken() async {
    try {
      // Replace 'YOUR_CLIENT_ID' and 'YOUR_CLIENT_SECRET' with your actual Spotify credentials
      final clientId = '5d01e47fab0844c9b7f5c7ed4cf12718';
      final clientSecret = '34fa810e6c054630939ea51cd226d2ec';

      final credentials = base64.encode(utf8.encode('$clientId:$clientSecret'));
      final response = await http.post(
        Uri.parse('https://accounts.spotify.com/api/token'),
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'grant_type=client_credentials',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final accessToken = data['access_token'];
        return accessToken;
      } else {
        throw Exception('Failed to obtain Spotify access token');
      }
    } catch (e) {
      print('Error getting access token: $e');
      return '';
    }
  }

  Future<void> fetchSpotifyTrackDetails(
      String trackId, String accessToken) async {
    try {
      final url = Uri.parse('https://api.spotify.com/v1/tracks/$trackId');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final trackName = data['name'];
        // You can add more fields from the Spotify API response as needed
        print('Track Name: $trackName');
        // Update UI or perform any other actions with track details
      } else {
        // Handle error when fetching track details
        print('Error fetching track details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching track details: $e');
    }
  }

  void _navigateToSongListPage(List<String> songs) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SongListPage(songs: songs),
      ),
    );
  }

  void _navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOGGED IN AS ${user.email!}',
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MoodButton(
                  emoji: '😊',
                  mood: 'happy',
                  onMoodSelected: _handleMoodSelected,
                ),
                MoodButton(
                  emoji: '😢',
                  mood: 'sad',
                  onMoodSelected: _handleMoodSelected,
                ),
                MoodButton(
                  emoji: '😌',
                  mood: 'calm',
                  onMoodSelected: _handleMoodSelected,
                ),
                MoodButton(
                  emoji: '🚀',
                  mood: 'energetic',
                  onMoodSelected: _handleMoodSelected,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Selected Mood: $selectedMood',
              style: TextStyle(fontSize: 20),
            ),
            if (spotifyTrackIds.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Spotify Track IDs for $selectedMood:',
                    style: TextStyle(fontSize: 20),
                  ),
                  for (String trackId in spotifyTrackIds)
                    TextButton(
                      onPressed: () async {
                        final accessToken = await getAccessToken();
                        fetchSpotifyTrackDetails(trackId, accessToken);
                      },
                      child: Text(
                        trackId,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToSongListPage(spotifyTrackIds);
                    },
                    child: Text('View Songs'),
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                _navigateToHomeScreen();
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMoodSelected(String mood) {
    fetchSpotifyTrackIds(mood);
  }
}

class MoodButton extends StatelessWidget {
  final String emoji;
  final String mood;
  final Function(String) onMoodSelected;

  MoodButton({
    required this.emoji,
    required this.mood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onMoodSelected(mood);
      },
      child: Column(
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: 30),
          ),
          Text(
            mood,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
