class Movie {
  final String? id;
  final String? imgUrl;
  final String? movieDirectorId;
  final String? nodeId;
  final DateTime? releaseDate;
  final String? title;
  final String? userCreatorId;

  const Movie({
    this.id,
    this.imgUrl,
    this.movieDirectorId,
    this.nodeId,
    this.releaseDate,
    this.title,
    this.userCreatorId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.id == id &&
        other.imgUrl == imgUrl &&
        other.movieDirectorId == movieDirectorId &&
        other.nodeId == nodeId &&
        other.releaseDate == releaseDate &&
        other.title == title &&
        other.userCreatorId == userCreatorId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imgUrl.hashCode ^
        movieDirectorId.hashCode ^
        nodeId.hashCode ^
        releaseDate.hashCode ^
        title.hashCode ^
        userCreatorId.hashCode;
  }
}
