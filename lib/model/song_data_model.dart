class SongData {
  dynamic name;
  dynamic album;
  dynamic artist;
  dynamic id;
  dynamic releaseDate;
  dynamic popularity;
  dynamic length;
  dynamic danceability;
  dynamic acousticness;
  dynamic energy;
  dynamic instrumentalness;
  dynamic liveness;
  dynamic valence;
  dynamic loudness;
  dynamic speechiness;
  dynamic tempo;
  dynamic key;
  dynamic timeSignature;
  dynamic mood;

  SongData(
      {this.name,
        this.album,
        this.artist,
        this.id,
        this.releaseDate,
        this.popularity,
        this.length,
        this.danceability,
        this.acousticness,
        this.energy,
        this.instrumentalness,
        this.liveness,
        this.valence,
        this.loudness,
        this.speechiness,
        this.tempo,
        this.key,
        this.timeSignature,
        this.mood});

  SongData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    album = json['album'];
    artist = json['artist'];
    id = json['id'];
    releaseDate = json['release_date'];
    popularity = json['popularity'];
    length = json['length'];
    danceability = json['danceability'];
    acousticness = json['acousticness'];
    energy = json['energy'];
    instrumentalness = json['instrumentalness'];
    liveness = json['liveness'];
    valence = json['valence'];
    loudness = json['loudness'];
    speechiness = json['speechiness'];
    tempo = json['tempo'];
    key = json['key'];
    timeSignature = json['time_signature'];
    mood = json['mood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['album'] = this.album;
    data['artist'] = this.artist;
    data['id'] = this.id;
    data['release_date'] = this.releaseDate;
    data['popularity'] = this.popularity;
    data['length'] = this.length;
    data['danceability'] = this.danceability;
    data['acousticness'] = this.acousticness;
    data['energy'] = this.energy;
    data['instrumentalness'] = this.instrumentalness;
    data['liveness'] = this.liveness;
    data['valence'] = this.valence;
    data['loudness'] = this.loudness;
    data['speechiness'] = this.speechiness;
    data['tempo'] = this.tempo;
    data['key'] = this.key;
    data['time_signature'] = this.timeSignature;
    data['mood'] = this.mood;
    return data;
  }
}
