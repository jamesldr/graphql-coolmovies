import 'package:coolmovies/core/auth/domain/entities/user.dart';
import 'package:coolmovies/core/shared/response_wrapper.dart';

abstract class IAuthRepository {
  Future<ResponseWrapper<User>> getCurrentUser();
  Future<ResponseWrapper<User>> getUserById(String id);
}
