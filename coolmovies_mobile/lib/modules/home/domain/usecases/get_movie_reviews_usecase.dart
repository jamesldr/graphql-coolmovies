import 'package:coolmovies/core/shared/response_wrapper.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';
import 'package:coolmovies/modules/home/domain/repositories/i_movies_repository.dart';

abstract class IGetMovieReviewsUsecase {
  Future<ResponseWrapper<List<MovieReview>>> call(Movie movie);
}

class GetMovieReviewsUsecase implements IGetMovieReviewsUsecase {
  final IMoviesRepository repository;

  const GetMovieReviewsUsecase(this.repository);

  @override
  Future<ResponseWrapper<List<MovieReview>>> call(Movie movie) async {
    return await repository.getReviewsByMovieId(movie.nodeId!);
  }
}
