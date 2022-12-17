import 'package:coolmovies/core/shared/response_wrapper.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/repositories/i_movies_repository.dart';

abstract class IGetMoviesListUsecase {
  Future<ResponseWrapper<List<Movie>>> call();
}

class GetMoviesListUsecase implements IGetMoviesListUsecase {
  final IMoviesRepository repository;

  const GetMoviesListUsecase(this.repository);

  @override
  Future<ResponseWrapper<List<Movie>>> call() async {
    return await repository.getAllMovies();
  }
}
