import 'package:coolmovies/core/auth/data/models/user_model.dart';
import 'package:coolmovies/core/auth/domain/entities/user.dart';
import 'package:coolmovies/modules/home/data/models/movie_director_model.dart';
import 'package:coolmovies/modules/home/data/models/movie_model.dart';
import 'package:coolmovies/modules/home/data/models/movie_review_model.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_director.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';

class ModelWrapper {
  static List<Movie> movie(Map<String, dynamic> json) {
    final map = json['allMovies']['nodes'];
    return List.generate(
      (map as List).length,
      (i) => MovieModel.fromJson(map[i]),
    );
  }

  static List<MovieReview> movieReview(Map<String, dynamic> json) {
    final map = json['movie']['movieReviewsByMovieId']['edges'];
    return List.generate(
      (map as List).length,
      (i) => MovieReviewModel.fromJson(map[i]['node']),
    );
  }

  static MovieDirector movieDirector(Map<String, dynamic> json) {
    final map = json['movieDirectorById'];
    return MovieDirectorModel.fromJson(map);
  }

  static User currentUser(Map<String, dynamic> json) {
    final map = json['currentUser'];
    return UserModel.fromJson(map);
  }
}
