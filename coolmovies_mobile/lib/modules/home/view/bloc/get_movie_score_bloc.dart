import 'dart:developer';

import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/usecases/get_movie_reviewer_rating_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMovieScoreBloc extends Cubit<BaseState> {
  GetMovieScoreBloc(this.usecase) : super(const EmptyState());
  final IGetMovieReviewerRatingUsecase usecase;
  call(Movie movie) async {
    emit(const LoadingState());
    final response = await usecase(movie);
    if (response.isSuccess) {
      log(response.data.toString());
      emit(SuccessState<double>(response.data!.toDouble()));
    }
    if (response.isError) {
      emit(ErrorState(message: response.errorMessage!));
    }
  }
}
