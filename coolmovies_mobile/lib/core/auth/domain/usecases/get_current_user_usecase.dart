import 'package:coolmovies/core/auth/data/repositories/auth_repository.dart';
import 'package:coolmovies/core/auth/domain/entities/user.dart';
import 'package:coolmovies/core/shared/response_wrapper.dart';

abstract class IGetCurrentUserUsecase {
  Future<ResponseWrapper<User>> call();
}

class GetCurrentUserUsecase implements IGetCurrentUserUsecase {
  final AuthRepository repository;

  GetCurrentUserUsecase(this.repository);
  @override
  Future<ResponseWrapper<User>> call() async {
    return await repository.getCurrentUser();
  }
}
