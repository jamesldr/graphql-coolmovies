import 'package:coolmovies/modules/home/domain/entities/movie_director.dart';

class MovieDirectorModel extends MovieDirector {
  MovieDirectorModel({
    required super.id,
    required super.name,
    required super.age,
    required super.nodeId,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'age': age});
    result.addAll({'nodeId': nodeId});

    return result;
  }

  factory MovieDirectorModel.fromJson(Map<String, dynamic> map) {
    return MovieDirectorModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      nodeId: map['nodeId'] ?? '',
    );
  }
}
