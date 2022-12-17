import 'package:coolmovies/core/shared/response_wrapper.dart';
import 'package:coolmovies/modules/home/domain/repositories/i_movies_repository.dart';

abstract class IDeleteReviewUsecase {
  Future<ResponseWrapper<bool>> call(String id);
}

class DeleteReviewUsecase implements IDeleteReviewUsecase {
  final IMoviesRepository repository;

  DeleteReviewUsecase(this.repository);

  @override
  Future<ResponseWrapper<bool>> call(String id) async {
    return await repository.deleteReviewById(id);
  }
}
