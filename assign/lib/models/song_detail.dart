class Song {
  final String title;
  final int duration;
  final String preview;
  final String artistName;
  final String albumTitle;
  final String coverMedium;
  bool liked;

  Song({
    required this.title,
    required this.duration,
    required this.preview,
    required this.artistName,
    required this.albumTitle,
    required this.coverMedium,
    this.liked = false,
  });

  Song copyWith({
    String? title,
    int? duration,
    String? preview,
    String? artistName,
    String? albumTitle,
    String? coverMedium,
    bool? liked,
  }) {
    return Song(
      title: title ?? this.title,
      duration: duration ?? this.duration,
      preview: preview ?? this.preview,
      artistName: artistName ?? this.artistName,
      albumTitle: albumTitle ?? this.albumTitle,
      coverMedium: coverMedium ?? this.coverMedium,
      liked: liked ?? this.liked,
    );
  }
   factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json['title'],
      duration: json['duration'],
      preview: json['preview'],
      artistName: json['artist']['name'],
      albumTitle: json['album']['title'],
      coverMedium: json['album']['cover_medium'],
    );
  }
}

