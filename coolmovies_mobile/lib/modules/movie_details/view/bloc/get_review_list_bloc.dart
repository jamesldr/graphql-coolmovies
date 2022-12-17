import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';
import 'package:coolmovies/modules/home/domain/usecases/get_movie_reviews_usecase.dart';
import 'package:coolmovies/modules/home/view/bloc/get_movie_score_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetReviewListBloc extends Cubit<BaseState> {
  final IGetMovieReviewsUsecase getReviewsUsecase;
  final GetMovieScoreBloc getMovieScoreBloc;

  GetReviewListBloc(
    this.getReviewsUsecase,
    this.getMovieScoreBloc,
  ) : super(const EmptyState());

  Future call(Movie movie) async {
    emit(const LoadingState());
    final response = await getReviewsUsecase(movie);

    if (response.isSuccess) {
      emit(SuccessState<List<MovieReview>>(response.data!));
      getMovieScoreBloc(movie);
    }
    if (response.isError) {
      emit(ErrorState(message: response.errorMessage!));
    }
  }
}
