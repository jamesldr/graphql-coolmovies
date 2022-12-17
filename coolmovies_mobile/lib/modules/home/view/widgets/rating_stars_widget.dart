import 'package:coolmovies/core/inject/app_injectors.dart';
import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/view/bloc/get_movie_score_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingStarsWidget extends StatefulWidget {
  final Movie movie;
  final int? score;
  final GetMovieScoreBloc? bloc;
  const RatingStarsWidget({
    required this.movie,
    this.score,
    this.bloc,
    Key? key,
  }) : super(key: key);

  @override
  State<RatingStarsWidget> createState() => _RatingStarsWidgetState();
}

class _RatingStarsWidgetState extends State<RatingStarsWidget> {
  late GetMovieScoreBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc =
        widget.bloc ?? GetMovieScoreBloc(AppInjector().getMovieReviewerRating);
    bloc(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: BlocBuilder<GetMovieScoreBloc, BaseState>(
        bloc: bloc,
        builder: ((context, state) {
          double rating = 0;

          if (widget.score == null) {
            if (state is SuccessState<double>) {
              rating = state.data;
            }
            if (state is LoadingState) {
              return const CircularProgressIndicator();
            }
          } else {
            rating = widget.score!.toDouble();
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(
                rating.floor(),
                (v) => const Icon(Icons.star, color: Colors.amber),
              ),
              if (rating.floor() < rating && rating.floor() < 5)
                const Icon(Icons.star_half, color: Colors.amber),
              if (rating.floor() < 5 && !(rating.floor() < rating))
                ...List.generate(
                  5 - rating.floor(),
                  (v) => const Icon(Icons.star_border, color: Colors.amber),
                ),
              if (rating.floor() < 5 && (rating.floor() < rating))
                ...List.generate(
                  4 - rating.floor(),
                  (v) => const Icon(Icons.star_border, color: Colors.amber),
                ),
            ],
          );
        }),
      ),
    );
  }
}
