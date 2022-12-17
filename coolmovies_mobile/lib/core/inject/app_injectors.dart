import 'package:coolmovies/core/auth/data/repositories/auth_repository.dart';
import 'package:coolmovies/core/auth/domain/entities/user.dart';
import 'package:coolmovies/core/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:coolmovies/core/auth/domain/usecases/get_user_by_user_id.dart';
import 'package:coolmovies/core/services/graphql_service.dart';
import 'package:coolmovies/modules/home/data/repositories/movies_repository.dart';
import 'package:coolmovies/modules/home/view/bloc/get_movie_list_bloc.dart';
import 'package:coolmovies/modules/movie_details/domain/usecases/delete_review_usecase.dart';
import 'package:coolmovies/modules/movie_details/domain/usecases/send_review_usecase.dart';
import 'package:coolmovies/modules/movie_details/domain/usecases/update_review_usecase.dart';

import '../../modules/home/domain/usecases/usecases.dart';

class AppInjector {
  AppInjector._privateConstructor();

  static final AppInjector _instance = AppInjector._privateConstructor();

  factory AppInjector() {
    return _instance;
  }

  //repository
  late MoviesRepository _movieRepository;
  late AuthRepository _authRepository;

  //usecase
  late IGetMovieReviewerRatingUsecase getMovieReviewerRating;
  late IGetMoviesListUsecase getMoviesList;
  late IGetMovieReviewsUsecase getMovieReviews;
  late IGetMovieDirectorByIdUsecase getMovieDirectorById;
  late ISendReviewUsecase sendReview;
  late IGetUserByUserIdUsecase getUserByUserId;
  late IUpdateReviewUsecase updateReview;
  late IDeleteReviewUsecase deleteReview;

  //  auth
  late User _currentUser;

  User get currentUser => _currentUser;

  //bloc
  late GetMovieListBloc homeBloc;

  init() async {
    final client = await GraphqlService.client;
    _repositories(client);
    await _getCurrentUser();
    _useCases();
    _blocs();
  }

  _repositories(GraphQLClient client) {
    _movieRepository = MoviesRepository(client);
    _authRepository = AuthRepository(client);
  }

  _useCases() {
    getMovieReviewerRating = GetMovieReviewerRatingUsecase(_movieRepository);
    getMoviesList = GetMoviesListUsecase(_movieRepository);
    getMovieReviews = GetMovieReviewsUsecase(_movieRepository);
    getMovieDirectorById = GetMovieDirectorByIdUsecase(_movieRepository);
    sendReview = SendReviewUsecase(_movieRepository, _currentUser);
    getUserByUserId = GetUserByUserIdUsecase(_authRepository);
    updateReview = UpdateReviewUsecase(_movieRepository);
    deleteReview = DeleteReviewUsecase(_movieRepository);
  }

  _blocs() {
    homeBloc = GetMovieListBloc(getMoviesList);
  }

  _getCurrentUser() async {
    try {
      final response = await GetCurrentUserUsecase(_authRepository)();
      _currentUser = response.data!;
    } catch (e) {
      _currentUser = User(name: '', id: '', nodeId: '');
    }
  }
}
