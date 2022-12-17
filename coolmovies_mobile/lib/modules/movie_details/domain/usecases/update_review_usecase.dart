import 'package:coolmovies/core/shared/response_wrapper.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';
import 'package:coolmovies/modules/home/domain/repositories/i_movies_repository.dart';

abstract class IUpdateReviewUsecase {
  Future<ResponseWrapper<bool>> call(MovieReview review);
}

class UpdateReviewUsecase implements IUpdateReviewUsecase {
  final IMoviesRepository repository;

  UpdateReviewUsecase(this.repository);
  @override
  Future<ResponseWrapper<bool>> call(MovieReview review) async {
    return await repository.updateReview(review);
  }
}
