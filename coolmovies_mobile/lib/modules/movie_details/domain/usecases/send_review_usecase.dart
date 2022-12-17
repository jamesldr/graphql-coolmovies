import 'package:coolmovies/core/auth/domain/entities/user.dart';
import 'package:coolmovies/core/shared/response_wrapper.dart';
import 'package:coolmovies/modules/home/data/repositories/movies_repository.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';

abstract class ISendReviewUsecase {
  Future<ResponseWrapper<bool>> call(MovieReview review);
}

class SendReviewUsecase implements ISendReviewUsecase {
  final MoviesRepository repository;
  final User currentUser;

  SendReviewUsecase(this.repository, this.currentUser);
  @override
  Future<ResponseWrapper<bool>> call(MovieReview review) async {
    return await repository.createReview(review.setUser(currentUser));
  }
}
