import 'package:flutter/material.dart';

const List<Map<String, String>> song_type_1 = [
  {"name": "Featured Playlist", "genre": "Featured"},
  {"name": "Rock", "genre": "rock"},
  {"name": "Soul", "genre": "soul"},
  {"name": "Classic", "genre": "classical"},
  {"name": "Pop", "genre": "pop"},
  {"name": "R&B", "genre": "rnb"},
  {"name": "Rap", "genre": "hiphop"},

  {"name": "Electronic", "genre": "0JQ5DAqbMKFHOzuVTgTizF"},
  {"name": "Party", "genre": "0JQ5DAqbMKFA6SOHvT3gck"},
  {"name": "Wellness", "genre": "0JQ5DAqbMKFLb2EqgLtpjC"},

  {"name": "Indie", "genre": "0JQ5DAqbMKFCWjUTdzaG0e"},
  {"name": "Summer", "genre": "0JQ5DAqbMKFLVaM30PMBm4"},
  {"name": "Romance", "genre": "0JQ5DAqbMKFAUsdyVjCQuL"},

  {"name": "K-Pop", "genre": "0JQ5DAqbMKFGvOw3O4nLAf"},
  {"name": "Mood", "genre": "0JQ5DAqbMKFzHmL4tf05da"},
  {"name": "Workout", "genre": "0JQ5DAqbMKFAXlCG6QvYQ4"},
  {"name": "Chill", "genre": "0JQ5DAqbMKFFzDl7qN9Apr"},
  {"name": "Focus", "genre": "0JQ5DAqbMKFCbimwdOYlsl"},
  // Add more genres as needed
];

const List song_type_2 = [
  {
    "name": "Podcasts",
    "category": "https://api.spotify.com/v1/search?q=podcasts&type=playlist"
  },
  {
    "name": "Made For You",
    "category": "https://api.spotify.com/v1/search?q=made_for_you&type=playlist"
  },
  {
    "name": "Charts",
    "category":
        "https://api.spotify.com/v1/browse/categories/toplists/playlists"
  },
  {
    "name": "New Releases",
    "category": "https://api.spotify.com/v1/search?q=new_releases&type=playlist"
  },
  {
    "name": "Discover",
    "category": "https://api.spotify.com/v1/search?q=discover&type=playlist"
  },
  {
    "name": "Concerts",
    "category":
        "https://api.spotify.com/v1/search?q=live_concerts&type=playlist"
  },
  {
    "name": "Kid",
    "category":
        "https://api.spotify.com/v1/search?q=kid_playlists&type=playlist"
  },
  {
    "name": "Teen",
    "category":
        "https://api.spotify.com/v1/search?q=teen_playlists&type=playlist"
  },
  {
    "name": "Young Adult",
    "category":
        "https://api.spotify.com/v1/search?q=young_playlists&type=playlist"
  },
  {
    "name": "Senior",
    "category":
        "https://api.spotify.com/v1/search?q=senior_citizen_playlists&type=playlist"
  },
];
const List songs = [
  {
    "img": "assets/images/img_3.jpg",
    "title": "Feelin' Good",
    "description": "Feel good with this positively timeless playlist!",
    "song_count": "100 songs",
    "date": "about 19 hr",
    "color": Color(0xFFf69129),
    "song_url": "audio/Salli.mp3",
    "songs": [
      {"title": "Imagination", "duration": "1:21"},
      {"title": "Home_", "duration": "2:17"},
      {"title": "Do I Wanna Know?", "duration": "1:31"},
      {"title": "Whiskey Sour", "duration": "1:42"},
      {"title": "Decisions", "duration": "1:29"},
      {"title": "Trees", "duration": "1:51"},
      {"title": "Earth", "duration": "1:39"},
    ]
  },
  {
    "img": "assets/images/img_5.jpg",
    "title": "Peaceful Piano",
    "description": "Relax and indulge with beautiful piano pieces",
    "song_count": "324 songs",
    "date": "about 14 hr",
    "color": Color(0xFF64849c),
    "song_url": "songs/2.mp3",
    "songs": [
      {"title": "Kaleidoscope", "duration": "2:01"},
      {"title": "Larks", "duration": "2:54"},
      {"title": "Homeland", "duration": "2:22"},
      {"title": "Une Danse", "duration": "3:03"},
      {"title": "Almonte", "duration": "2:31"},
      {"title": "Days Like These", "duration": "4:09"},
      {"title": "In questo momento", "duration": "2:40"},
    ]
  },
  {
    "img": "assets/images/img_7.jpg",
    "title": "Deep Focus",
    "description": "Keep calm and focus with ambient and post-rock music.",
    "song_count": "195 songs",
    "date": "about 10 hr",
    "color": Color(0xFF58546c),
    "song_url": "songs/1.mp3",
    "songs": [
      {"title": "Escaping Time", "duration": "3:20"},
      {"title": "Just Look at You", "duration": "3:07"},
      {"title": "Flowing", "duration": "2:11"},
      {"title": "With Resolve", "duration": "2:09"},
      {"title": "Infinite Sustain", "duration": "2:29"},
      {"title": "Ingénue", "duration": "2:38"},
      {"title": "Hidden Chambers", "duration": "2:49"},
    ]
  },
  {
    "img": "assets/images/img_4.jpg",
    "title": "Lo-Fi Beats",
    "description": "Beats to relax, study and focus.",
    "song_count": "599 songs",
    "date": "about 21 hr",
    "color": Color(0xFFbad6ec),
    "song_url": "songs/2.mp3",
    "songs": [
      {"title": "Imagination", "duration": "1:21"},
      {"title": "Home_", "duration": "2:17"},
      {"title": "Do I Wanna Know?", "duration": "1:31"},
      {"title": "Whiskey Sour", "duration": "1:42"},
      {"title": "Decisions", "duration": "1:29"},
      {"title": "Trees", "duration": "1:51"},
      {"title": "Earth", "duration": "1:39"},
    ]
  },
  {
    "img": "assets/images/img_2.jpg",
    "title": "Chill Lofi Study Beats",
    "description": "The perfect study beats, twenty four seven.",
    "song_count": "317 songs",
    "date": "about 11 hr",
    "color": Color(0xFF93689a),
    "song_url": "songs/1.mp3",
    "songs": [
      {"title": "Imagination", "duration": "1:21"},
      {"title": "Home_", "duration": "2:17"},
      {"title": "Do I Wanna Know?", "duration": "1:31"},
      {"title": "Whiskey Sour", "duration": "1:42"},
      {"title": "Decisions", "duration": "1:29"},
      {"title": "Trees", "duration": "1:51"},
      {"title": "Earth", "duration": "1:39"},
    ]
  },
  {
    "img": "assets/images/img_6.jpg",
    "title": "Chill Hits",
    "description": "Kick back to the best new and recent chill tunes.",
    "song_count": "130 songs",
    "date": "about 7 hr",
    "color": Color(0xFFa4c4d3),
    "song_url": "songs/2.mp3",
    "songs": [
      {"title": "Imagination", "duration": "1:21"},
      {"title": "Home_", "duration": "2:17"},
      {"title": "Do I Wanna Know?", "duration": "1:31"},
      {"title": "Whiskey Sour", "duration": "1:42"},
      {"title": "Decisions", "duration": "1:29"},
      {"title": "Trees", "duration": "1:51"},
      {"title": "Earth", "duration": "1:39"},
    ]
  },
  {
    "img": "assets/images/img_1.jpg",
    "title": "Dark & Stormy",
    "description": "Beautifully dark, dramatic tracks.",
    "song_count": "50 songs",
    "date": "about 17 hr",
    "color": Color(0xFF5e4f78),
    "song_url": "songs/1.mp3",
    "songs": [
      {"title": "Kaleidoscope", "duration": "2:01"},
      {"title": "Larks", "duration": "2:54"},
      {"title": "Homeland", "duration": "2:22"},
      {"title": "Une Danse", "duration": "3:03"},
      {"title": "Almonte", "duration": "2:31"},
      {"title": "Days Like These", "duration": "4:09"},
      {"title": "In questo momento", "duration": "2:40"},
    ]
  },
  {
    "img": "assets/images/img_8.jpg",
    "title": "Feel Good Piano",
    "description": "Positive piano music",
    "song_count": "69 songs",
    "date": "2 hr 14 min",
    "color": Color(0xFFa4c1ad),
    "song_url": "songs/2.mp3",
    "songs": [
      {"title": "Escaping Time", "duration": "3:20"},
      {"title": "Just Look at You", "duration": "3:07"},
      {"title": "Flowing", "duration": "2:11"},
      {"title": "With Resolve", "duration": "2:09"},
      {"title": "Infinite Sustain", "duration": "2:29"},
      {"title": "Ingénue", "duration": "2:38"},
      {"title": "Hidden Chambers", "duration": "2:49"},
    ]
  },
  {
    "img": "assets/images/img_9.jpg",
    "title": "Sad Songs",
    "description": "Beautiful songs to break your heart...",
    "song_count": "60 songs",
    "date": "3 hr 25 min",
    "color": Color(0xFFd9e3ec),
    "song_url": "songs/1.mp3",
    "songs": [
      {"title": "Imagination", "duration": "1:21"},
      {"title": "Home_", "duration": "2:17"},
      {"title": "Do I Wanna Know?", "duration": "1:31"},
      {"title": "Whiskey Sour", "duration": "1:42"},
      {"title": "Decisions", "duration": "1:29"},
      {"title": "Trees", "duration": "1:51"},
      {"title": "Earth", "duration": "1:39"},
    ]
  },
  {
    "img": "assets/images/img_10.jpg",
    "title": "Mood Booster",
    "description": "Get happy with today's dose of feel-good songs",
    "song_count": "75 songs",
    "date": "3 hr 56 min",
    "color": Color(0xFF4e6171),
    "song_url": "songs/2.mp3",
    "songs": [
      {"title": "Imagination", "duration": "1:21"},
      {"title": "Home_", "duration": "2:17"},
      {"title": "Do I Wanna Know?", "duration": "1:31"},
      {"title": "Whiskey Sour", "duration": "1:42"},
      {"title": "Decisions", "duration": "1:29"},
      {"title": "Trees", "duration": "1:51"},
      {"title": "Earth", "duration": "1:39"},
    ]
  }
];
