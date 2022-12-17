import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';
import 'package:coolmovies/modules/movie_details/domain/usecases/send_review_usecase.dart';
import 'package:coolmovies/modules/movie_details/domain/usecases/update_review_usecase.dart';
import 'package:coolmovies/modules/movie_details/view/bloc/get_review_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendReviewBloc extends Cubit<BaseState> {
  SendReviewBloc({
    required this.usecase,
    required this.updateUsecase,
    required this.reviewListBloc,
  }) : super(const EmptyState());

  final ISendReviewUsecase usecase;
  final IUpdateReviewUsecase updateUsecase;
  final GetReviewListBloc reviewListBloc;

  Future call(MovieReview review, Movie movie) async {
    emit(const LoadingState());
    final response = await usecase(review);

    if (response.isSuccess && response.data == true) {
      await reviewListBloc(movie);

      emit(SuccessState(response.data));
    } else if (state is ErrorState) {
      emit(ErrorState(message: state.toString()));
    } else {
      emit(const ErrorState(message: 'Could not connect to the server'));
    }
  }

  update(Movie movie, MovieReview review) async {
    emit(const LoadingState());
    final response = await updateUsecase(review);
    if (response.isSuccess) {
      emit(SuccessState(response.data!));
      reviewListBloc(movie);
    }
    if (response.isError) {
      emit(
        ErrorState(message: response.errorMessage!),
      );
    }
  }

  dispose() {
    emit(const EmptyState());
  }
}
