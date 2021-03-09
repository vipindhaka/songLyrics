class Lyrics {
  String lyrics;
  Lyrics(this.lyrics);

  Lyrics.fromJson(Map<String, dynamic> data) {
    lyrics = data['lyrics_body'];
  }
}
