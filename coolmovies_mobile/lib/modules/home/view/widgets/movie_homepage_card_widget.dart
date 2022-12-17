import 'package:auto_size_text/auto_size_text.dart';
import 'package:coolmovies/core/inject/app_injectors.dart';
import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_director.dart';
import 'package:coolmovies/modules/home/view/bloc/get_movie_director_bloc.dart';
import 'package:coolmovies/modules/home/view/widgets/rating_stars_widget.dart';
import 'package:coolmovies/modules/movie_details/movie_details_route.dart';
import 'package:coolmovies/modules/movie_details/view/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MovieHomepageCard extends StatefulWidget {
  const MovieHomepageCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  State<MovieHomepageCard> createState() => _MovieHomepageCardState();
}

class _MovieHomepageCardState extends State<MovieHomepageCard> {
  late GetMovieDirectorBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = GetMovieDirectorBloc(AppInjector().getMovieDirectorById);
    bloc(widget.movie);
  }

  void onTap() {
    context.push(
      MovieDetailsRoute.root,
      extra: MovieDetailsPageParams(
        movieId: widget.movie.id!,
        movieNodeId: widget.movie.nodeId!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const coverSize = Size(134, 200);

    return SizedBox(
      height: coverSize.height + 32,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.movie.imgUrl ?? '',
                child: Container(
                  height: coverSize.height,
                  width: coverSize.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.movie.imgUrl ?? '',
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: RatingStarsWidget(movie: widget.movie),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.movie.title ?? '',
                      softWrap: true,
                      minFontSize: 24,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<GetMovieDirectorBloc, BaseState>(
                      bloc: bloc,
                      builder: ((context, state) {
                        String director = '';
                        if (state is SuccessState<MovieDirector>) {
                          director = state.data.name;
                        }
                        return Visibility(
                          visible: director.isNotEmpty,
                          child: AutoSizeText(
                            'Directed by: $director',
                            softWrap: true,
                            minFontSize: 11,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: onTap,
                          child: AutoSizeText(
                            'See Reviews',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            softWrap: true,
                            minFontSize: 16,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
