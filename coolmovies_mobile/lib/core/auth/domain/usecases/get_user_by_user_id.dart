import 'package:coolmovies/core/auth/domain/entities/user.dart';
import 'package:coolmovies/core/auth/domain/repositories/i_auth_repository.dart';
import 'package:coolmovies/core/shared/response_wrapper.dart';

abstract class IGetUserByUserIdUsecase {
  Future<ResponseWrapper<User>> call(String id);
}

class GetUserByUserIdUsecase extends IGetUserByUserIdUsecase {
  final IAuthRepository repository;
  GetUserByUserIdUsecase(this.repository);

  @override
  Future<ResponseWrapper<User>> call(String id) async {
    return await repository.getUserById(id);
  }
}
