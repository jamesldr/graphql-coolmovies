import 'package:coolmovies/core/shared/response_wrapper.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/repositories/i_movies_repository.dart';

abstract class IGetMovieReviewerRatingUsecase {
  Future<ResponseWrapper<num>> call(Movie movie);
}

class GetMovieReviewerRatingUsecase implements IGetMovieReviewerRatingUsecase {
  final IMoviesRepository repository;

  const GetMovieReviewerRatingUsecase(this.repository);

  @override
  Future<ResponseWrapper<num>> call(Movie movie) async {
    return await repository.getMovieRatingByMovieId(movie.nodeId!);
  }
}
