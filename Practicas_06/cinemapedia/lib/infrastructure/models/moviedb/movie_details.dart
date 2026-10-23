class MovieDetails {
  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        adult: json['adult'] ?? false,
        backdropPath: json['backdrop_path'] ?? '',
        genreIds: (json['genres'] as List<dynamic>? ?? [])
            .map((genre) => (genre as Map<String, dynamic>)['id'] as int)
            .toList(),
        id: json['id'] ?? 0,
        originalLanguage: json['original_language'] ?? '',
        originalTitle: json['original_title'] ?? '',
        overview: json['overview'] ?? '',
        popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
        posterPath: json['poster_path'] ?? '',
        releaseDate: json['release_date'] != null && json['release_date'].toString().isNotEmpty
            ? DateTime.parse(json['release_date'])
            : null,
        title: json['title'] ?? 'No Title',
        video: json['video'] ?? false,
        voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
        voteCount: json['vote_count'] ?? 0,
      );
}
