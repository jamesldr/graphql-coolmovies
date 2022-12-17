import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';
import 'package:coolmovies/modules/movie_details/domain/usecases/delete_review_usecase.dart';
import 'package:coolmovies/modules/movie_details/view/bloc/get_review_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteReviewBloc extends Cubit<BaseState> {
  final IDeleteReviewUsecase deleteUsecase;

  final GetReviewListBloc getReviewListBloc;

  DeleteReviewBloc(
    this.deleteUsecase,
    this.getReviewListBloc,
  ) : super(const EmptyState());

  call(Movie movie, MovieReview review) async {
    emit(const LoadingState());
    final response = await deleteUsecase(review.id!);
    if (response.isSuccess) {
      emit(SuccessState(response.data!));
      getReviewListBloc(movie);
    }
    if (response.isError) {
      emit(ErrorState(message: response.errorMessage!));
    }
  }
}
