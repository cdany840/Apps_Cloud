class PopularModel {
    String? backdropPath;
    int? id;
    String? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    DateTime? releaseDate;
    String? title;
    double? voteAverage;
    int? voteCount;

    PopularModel({    
      this.backdropPath,    
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,    
      this.voteAverage,
      this.voteCount,
    });

    factory PopularModel.fromJson(Map<String, dynamic> map) => PopularModel(    
        backdropPath: map["backdrop_path"] ?? '',    
        id: map["id"],
        originalLanguage: map["original_language"],
        originalTitle: map["original_title"],
        overview: map["overview"],
        popularity: map["popularity"]?.toDouble(),
        posterPath: map["poster_path"] ?? '',
        releaseDate: DateTime.parse(map["release_date"]),
        title: map["title"],    
        voteAverage: map["vote_average"]?.toDouble(),
        voteCount: map["vote_count"],
    );

    Map<String, dynamic> toJson() => {    
        "backdrop_path": backdropPath,    
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        // "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,    
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
