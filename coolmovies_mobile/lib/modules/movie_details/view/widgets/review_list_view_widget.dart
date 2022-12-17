import 'package:auto_size_text/auto_size_text.dart';
import 'package:coolmovies/core/inject/app_injectors.dart';
import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';
import 'package:coolmovies/modules/home/view/widgets/rating_stars_widget.dart';
import 'package:coolmovies/modules/movie_details/view/bloc/get_review_list_bloc.dart';
import 'package:coolmovies/modules/movie_details/view/bloc/manage_review_bloc.dart';
import 'package:coolmovies/modules/movie_details/view/bloc/send_review_bloc.dart';
import 'package:coolmovies/modules/movie_details/view/widgets/create_review_modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewListView extends StatefulWidget {
  const ReviewListView({
    super.key,
    required this.movie,
    required this.bloc,
    required this.sendReviewBloc,
  });
  final Movie movie;
  final GetReviewListBloc bloc;
  final SendReviewBloc sendReviewBloc;

  @override
  State<ReviewListView> createState() => _ReviewListViewState();
}

class _ReviewListViewState extends State<ReviewListView> {
  late DeleteReviewBloc manageReviewBloc;
  @override
  void initState() {
    super.initState();

    manageReviewBloc = DeleteReviewBloc(
      AppInjector().deleteReview,
      widget.bloc,
    );

    widget.bloc(widget.movie);
  }

  Widget _itemBuilder(BuildContext context, int index, {MovieReview? review}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AutoSizeText(
                    review?.title ?? '',
                    maxLines: 3,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: FittedBox(
                    child: RatingStarsWidget(
                      movie: widget.movie,
                      score: review?.rating,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(review?.body ?? ''),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (review?.user?.id == AppInjector().currentUser.id)
                  Expanded(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            CreateReviewModal(
                              movie: widget.movie,
                              sendReviewBloc: widget.sendReviewBloc,
                              review: review,
                              manageReviewBloc: manageReviewBloc,
                            ).show(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.edit),
                          ),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            manageReviewBloc.call(widget.movie, review!);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.delete),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                Text(
                  '-  ${review?.user?.name}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final bodyTextEditingController = TextEditingController();
  final titleTextEditingController = TextEditingController();
  final GlobalObjectKey<FormState> formKey =
      const GlobalObjectKey<FormState>('form');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Reviews',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        BlocBuilder<GetReviewListBloc, BaseState>(
            bloc: widget.bloc,
            builder: (context, state) {
              if (state is SuccessState<List<MovieReview>>) {
                return ListView.builder(
                  itemCount: state.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _itemBuilder(
                      context,
                      index,
                      review: state.data[index],
                    );
                  },
                );
              }
              return ListView.builder(
                itemCount: [].length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: _itemBuilder,
              );
            }),
      ],
    );
  }
}
