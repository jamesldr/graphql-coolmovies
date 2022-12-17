import 'package:coolmovies/modules/home/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    super.id,
    super.imgUrl,
    super.movieDirectorId,
    super.nodeId,
    super.releaseDate,
    super.title,
    super.userCreatorId,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    if (id != null) result.addAll({'id': id});
    if (imgUrl != null) result.addAll({'imgUrl': imgUrl});
    if (nodeId != null) result.addAll({'nodeId': nodeId});
    if (title != null) result.addAll({'title': title});

    if (movieDirectorId != null) {
      result.addAll({'movieDirectorId': movieDirectorId});
    }

    if (releaseDate != null) {
      result.addAll({'releaseDate': releaseDate!.millisecondsSinceEpoch});
    }

    if (userCreatorId != null) {
      result.addAll({'userCreatorId': userCreatorId});
    }

    return result;
  }

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'],
      imgUrl: map['imgUrl'],
      movieDirectorId: map['movieDirectorId'],
      nodeId: map['nodeId'],
      releaseDate: map['releaseDate'] != null
          ? DateTime.tryParse(map['releaseDate'])
          : null,
      title: map['title'],
      userCreatorId: map['userCreatorId'],
    );
  }
}
