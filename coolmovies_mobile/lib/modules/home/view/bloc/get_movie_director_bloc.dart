import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_director.dart';
import 'package:coolmovies/modules/home/domain/usecases/get_movie_director_by_id_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMovieDirectorBloc extends Cubit<BaseState> {
  final IGetMovieDirectorByIdUsecase getDirectorUsecase;

  GetMovieDirectorBloc(this.getDirectorUsecase) : super(const EmptyState());

  Future call(Movie movie) async {
    emit(const LoadingState());
    final response = await getDirectorUsecase(movie);
    if (response.isSuccess) {
      emit(
        SuccessState<MovieDirector>(response.data!),
      );
    }
    if (response.isError) {
      emit(ErrorState(message: response.errorMessage!));
    }
  }
}
