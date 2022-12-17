import 'package:coolmovies/core/inject/app_injectors.dart';
import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_director.dart';
import 'package:coolmovies/modules/home/view/bloc/get_movie_director_bloc.dart';
import 'package:coolmovies/modules/home/view/bloc/get_movie_list_bloc.dart';
import 'package:coolmovies/modules/home/view/bloc/get_movie_score_bloc.dart';
import 'package:coolmovies/modules/home/view/widgets/rating_stars_widget.dart';
import 'package:coolmovies/modules/movie_details/view/bloc/get_review_list_bloc.dart';
import 'package:coolmovies/modules/movie_details/view/bloc/send_review_bloc.dart';
import 'package:coolmovies/modules/movie_details/view/widgets/create_review_modal_widget.dart';
import 'package:coolmovies/modules/movie_details/view/widgets/review_list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsPageParams {
  final String movieId;
  final String movieNodeId;

  MovieDetailsPageParams({required this.movieId, required this.movieNodeId});
}

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.params});

  final MovieDetailsPageParams params;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final GetMovieListBloc getMovieListBloc = AppInjector().homeBloc;

  final scoreBloc = GetMovieScoreBloc(AppInjector().getMovieReviewerRating);

  late GetReviewListBloc reviewListViewBloc;

  final GetMovieDirectorBloc getMovieDirectorBloc = GetMovieDirectorBloc(
    AppInjector().getMovieDirectorById,
  );

  late SendReviewBloc sendReviewBloc;
  Movie? movie;
  String title = '';
  @override
  void initState() {
    super.initState();

    reviewListViewBloc = GetReviewListBloc(
      AppInjector().getMovieReviews,
      scoreBloc,
    );
    sendReviewBloc = SendReviewBloc(
      usecase: AppInjector().sendReview,
      reviewListBloc: reviewListViewBloc,
      updateUsecase: AppInjector().updateReview,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMovieListBloc, BaseState>(
        bloc: getMovieListBloc,
        builder: (ctx, state) {
          if (state is SuccessState) {
            movie = getMovieListBloc.getMovieById(widget.params.movieId)!;
            title = movie!.title!;
            getMovieDirectorBloc(movie!);
          }
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              title: Text(title),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                CreateReviewModal(
                  movie: movie!,
                  sendReviewBloc: sendReviewBloc,
                ).show(context);
              },
              backgroundColor: Colors.black,
              label: const Text(
                'Submit Review',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag: movie?.imgUrl ?? '',
                                    child: Image.network(
                                      movie?.imgUrl ?? '',
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder(
                        bloc: getMovieDirectorBloc,
                        builder: (context, state) {
                          String director = '';
                          if (state is SuccessState<MovieDirector>) {
                            director = state.data.name;
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Director:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                director,
                                style: const TextStyle(
                                  fontSize: 18,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Movie Score:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RatingStarsWidget(
                                  movie: movie!,
                                  bloc: scoreBloc,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (movie != null)
                        ReviewListView(
                          movie: movie!,
                          bloc: reviewListViewBloc,
                          sendReviewBloc: sendReviewBloc,
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
