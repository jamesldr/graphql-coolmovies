import 'package:coolmovies/core/shared/response_wrapper.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_director.dart';
import 'package:coolmovies/modules/home/domain/repositories/i_movies_repository.dart';

abstract class IGetMovieDirectorByIdUsecase {
  Future<ResponseWrapper<MovieDirector>> call(Movie movie);
}

class GetMovieDirectorByIdUsecase implements IGetMovieDirectorByIdUsecase {
  final IMoviesRepository repository;

  GetMovieDirectorByIdUsecase(this.repository);
  @override
  Future<ResponseWrapper<MovieDirector>> call(Movie movie) async {
    return await repository.getMovieDirectorById(movie.movieDirectorId ?? '');
  }
}
