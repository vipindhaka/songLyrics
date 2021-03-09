class Track {
  String trackName, albumName, artistName;
  int trackId;
  int rating;
  bool explicit;

  Track(this.trackName, this.albumName, this.artistName, this.trackId,
      this.rating, this.explicit);

  Track.fromJson(Map<String, dynamic> data) {
    trackName = data['track_name'];
    albumName = data['album_name'];
    artistName = data['artist_name'];
    trackId = data['track_id'];
    rating = data['track_rating'];
    data['explicit'] == 0 ? explicit = false : explicit = true;
  }
}
