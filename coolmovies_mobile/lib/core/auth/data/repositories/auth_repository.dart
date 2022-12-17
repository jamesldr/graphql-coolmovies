import 'dart:developer';

import 'package:coolmovies/core/auth/domain/entities/user.dart';
import 'package:coolmovies/core/auth/domain/repositories/i_auth_repository.dart';
import 'package:coolmovies/modules/home/data/models/model_wrapper.dart';
import 'package:flutter/foundation.dart';

import '../../../services/graphql_service.dart';
import '../../../shared/response_wrapper.dart';

class AuthRepository implements IAuthRepository {
  final GraphQLClient client;
  AuthRepository(this.client);

  @override
  Future<ResponseWrapper<User>> getCurrentUser() async {
    const document = '''query MyQuery {
  currentUser {
    name
    id
    nodeId
  }
}

''';

    try {
      late final QueryResult<User> response;
      try {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.networkOnly,
            parserFn: ModelWrapper.currentUser,
          ),
        );
      } catch (e) {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.cacheOnly,
            parserFn: ModelWrapper.currentUser,
          ),
        );
      }

      if (kDebugMode) {
        log((response.data).toString());
      }

      return ResponseWrapper(data: response.parsedData);
    } catch (e) {
      return ResponseWrapper(errorMessage: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<User>> getUserById(String id) async {
    const document = '''query MyQuery {''';
    try {
      late final QueryResult<User> response;
      try {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.networkOnly,
            parserFn: ModelWrapper.currentUser,
          ),
        );
      } catch (e) {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.cacheOnly,
            parserFn: ModelWrapper.currentUser,
          ),
        );
      }

      if (kDebugMode) {
        log((response.data).toString());
      }

      return ResponseWrapper(data: response.parsedData);
    } catch (e) {
      return ResponseWrapper(errorMessage: e.toString());
    }
  }
}
