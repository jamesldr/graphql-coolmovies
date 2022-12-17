import 'package:coolmovies/core/shared/response_wrapper.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_director.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';

abstract class IMoviesRepository {
  Future<ResponseWrapper<List<Movie>>> getAllMovies();

  Future<ResponseWrapper<List<MovieReview>>> getReviewsByMovieId(String nodeID);

  Future<ResponseWrapper<num>> getMovieRatingByMovieId(String nodeID);

  Future<ResponseWrapper<MovieDirector>> getMovieDirectorById(String id);

  Future<ResponseWrapper<bool>> createReview(MovieReview review);

  Future<ResponseWrapper<bool>> updateReview(MovieReview review);

  Future<ResponseWrapper<bool>> deleteReviewById(String id);
}
