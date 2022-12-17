import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMovieListBloc extends Cubit<BaseState> {
  GetMovieListBloc(this.usecase) : super(const EmptyState());

  final IGetMoviesListUsecase usecase;

  List<Movie> _movies = [];

  Future call() async {
    emit(const LoadingState());
    final response = await usecase();

    if (response.isSuccess) {
      if (response.data?.isNotEmpty == true) {
        _movies = response.data!;
        emit(SuccessState<List<Movie>>(response.data!));
      } else {
        emit(const EmptyState());
      }
    }
    if (response.isError) {
      if (response.errorMessage != null) {
        emit(ErrorState(message: response.errorMessage!));
      }
      emit(const ErrorState());
    }
  }

  Movie? getMovieById(String id) {
    Movie? result;
    for (var i = 0; i < _movies.length; i++) {
      if (_movies[i].id == id) {
        result = _movies[i];
        break;
      }
    }
    return result;
  }
}
