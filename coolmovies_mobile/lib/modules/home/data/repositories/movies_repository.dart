import 'dart:developer';

import 'package:coolmovies/core/shared/response_wrapper.dart';
import 'package:coolmovies/modules/home/data/models/model_wrapper.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_director.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';
import 'package:coolmovies/modules/home/domain/repositories/i_movies_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MoviesRepository implements IMoviesRepository {
  final GraphQLClient client;
  const MoviesRepository(this.client);

  @override
  Future<ResponseWrapper<List<Movie>>> getAllMovies() async {
    const document = '''query MyQuery {
  allMovies {
    nodes {
      id
      imgUrl
      movieDirectorId
      nodeId
      releaseDate
      title
      userCreatorId
    }
  }
}''';

    try {
      late final QueryResult<List<Movie>> response;
      try {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.networkOnly,
            parserFn: ModelWrapper.movie,
          ),
        );
      } catch (e) {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.cacheOnly,
            parserFn: ModelWrapper.movie,
          ),
        );
      }

      if (kDebugMode) {
        log((response.data).toString());
      }

      return ResponseWrapper(data: response.parsedData ?? []);
    } catch (e) {
      return ResponseWrapper(errorMessage: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<List<MovieReview>>> getReviewsByMovieId(
    String nodeID,
  ) async {
    final document = '''query MyQuery {
  movie(nodeId: "$nodeID") {
    movieReviewsByMovieId {
      edges {
        node {
          id
          body
          title
          rating
          userReviewerId
          nodeId
          movieId
          userByUserReviewerId {
            name
            nodeId
            id
          }
        }
      }
    }
  }
}

''';
    try {
      late final QueryResult<List<MovieReview>> response;
      try {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.networkOnly,
            parserFn: ModelWrapper.movieReview,
          ),
        );
      } catch (e) {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.cacheOnly,
            parserFn: ModelWrapper.movieReview,
          ),
        );
      }

      return ResponseWrapper(data: response.parsedData!.reversed.toList());
    } catch (e) {
      return ResponseWrapper(errorMessage: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<double>> getMovieRatingByMovieId(String nodeID) async {
    try {
      final response = await getReviewsByMovieId(nodeID);
      final reviews = response.data!;
      int sum = 0;
      int i = 0;
      for (i; i < (reviews.length); i++) {
        sum += reviews[i].rating ?? 0;
      }
      final result = (sum / i);
      return ResponseWrapper(data: result);
    } catch (e) {
      return ResponseWrapper(errorMessage: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<MovieDirector>> getMovieDirectorById(String id) async {
    final document = '''query MyQuery {
  movieDirectorById(id: "$id") {
    id
    name
    age
    nodeId
  }
}

''';
    try {
      late final QueryResult<MovieDirector> response;
      try {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.networkOnly,
            parserFn: ModelWrapper.movieDirector,
          ),
        );
      } catch (e) {
        response = await client.query(
          QueryOptions(
            document: gql(document),
            fetchPolicy: FetchPolicy.cacheOnly,
            parserFn: ModelWrapper.movieDirector,
          ),
        );
      }

      return ResponseWrapper(data: response.parsedData);
    } catch (e) {
      return ResponseWrapper(errorMessage: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> createReview(MovieReview review) async {
    final document = '''
mutation MyMutation {
  createMovieReview(
    input: {
      movieReview: ${review.toString()}
       clientMutationId: "review-movie-${DateTime.now().millisecondsSinceEpoch}"
    }
  ) {
    clientMutationId
  }
}

    ''';

    bool success = false;

    try {
      final response = await client.mutate(
        MutationOptions(document: gql(document)),
      );
      success = !response.hasException;
      return ResponseWrapper(data: success);
    } catch (e) {
      return ResponseWrapper(errorMessage: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> deleteReviewById(String id) async {
    final document = '''
    mutation MyMutation {
      deleteMovieReviewById(input: {id: "$id"}) {
        clientMutationId
        deletedMovieReviewId
      }
    }


''';
    bool success = false;

    try {
      final response = await client.mutate(
        MutationOptions(document: gql(document)),
      );
      success = !response.hasException;
      return ResponseWrapper(data: success);
    } catch (e) {
      return ResponseWrapper(errorMessage: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> updateReview(MovieReview review) async {
    final document = '''

    mutation MyMutation {
  updateMovieReviewById(
    input: {
      movieReviewPatch: ${review.toString()}
      id: "${review.id}"
    }
  )  {
    clientMutationId
  }
}
    ''';
    bool success = false;

    try {
      final response = await client.mutate(
        MutationOptions(document: gql(document)),
      );
      success = !response.hasException;
      return ResponseWrapper(data: success);
    } catch (e) {
      return ResponseWrapper(errorMessage: e.toString());
    }
  }
}
