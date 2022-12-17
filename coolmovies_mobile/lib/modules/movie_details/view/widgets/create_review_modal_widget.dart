import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/core/shared/simple_bloc.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';
import 'package:coolmovies/modules/movie_details/view/bloc/manage_review_bloc.dart';
import 'package:coolmovies/modules/movie_details/view/bloc/send_review_bloc.dart';
import 'package:coolmovies/modules/movie_details/view/widgets/score_star_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateReviewModal extends StatefulWidget {
  final Movie movie;
  final SendReviewBloc sendReviewBloc;
  final MovieReview? review;
  final DeleteReviewBloc? manageReviewBloc;

  const CreateReviewModal({
    super.key,
    required this.movie,
    required this.sendReviewBloc,
    this.review,
    this.manageReviewBloc,
  });

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => CreateReviewModal(
        movie: movie,
        sendReviewBloc: sendReviewBloc,
        review: review,
        manageReviewBloc: manageReviewBloc,
      ),
    );
  }

  @override
  State<CreateReviewModal> createState() => _CreateReviewModalState();
}

class _CreateReviewModalState extends State<CreateReviewModal> {
  final GlobalObjectKey<FormState> formKey = const GlobalObjectKey('formKey');
  late TextEditingController titleTextEditingController;
  late TextEditingController bodyTextEditingController;

  late SimpleBloc<int> ratingBloc;

  @override
  void initState() {
    super.initState();
    titleTextEditingController =
        TextEditingController(text: widget.review?.title);
    bodyTextEditingController =
        TextEditingController(text: widget.review?.body);

    ratingBloc = SimpleBloc<int>(widget.review?.rating ?? 1);
  }

  Future sendReviewMethod() async {
    if (formKey.currentState?.validate() != true) return;

    final review = MovieReview(
      id: widget.review?.id,
      nodeId: widget.review?.nodeId,
      user: widget.review?.user,
      userReviewerId: widget.review?.user?.id,
      title: titleTextEditingController.text,
      body: bodyTextEditingController.text,
      rating: ratingBloc.state,
      movieId: widget.movie.id,
    );

    if (widget.review != null) {
      await widget.sendReviewBloc.update(widget.movie, review);
    } else {
      await widget.sendReviewBloc(review, widget.movie);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.sendReviewBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BlocBuilder<SendReviewBloc, BaseState>(
          bloc: widget.sendReviewBloc,
          builder: (context, state) {
            bool canSubmitReview = (state is! LoadingState);

            if (state is SuccessState) {
              bodyTextEditingController.clear();
              titleTextEditingController.clear();

              Navigator.pop(context);
            }
            if (state is ErrorState) {
              final snackBar = SnackBar(
                content: Row(
                  children: const [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'There was an error, please try again later',
                      ),
                    ),
                  ],
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Score:',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Spacer(),
                                        BlocBuilder<SimpleBloc<int>, int>(
                                          bloc: ratingBloc,
                                          builder: (context, state) {
                                            return ScoreStarSelector(
                                              value: state,
                                              onTap: (v) => ratingBloc(v),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: titleTextEditingController,
                                    minLines: 1,
                                    validator: (value) {
                                      return value?.isNotEmpty != true
                                          ? 'Required field'
                                          : null;
                                    },
                                    decoration: const InputDecoration(
                                      label: Text('Title'),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: bodyTextEditingController,
                                    maxLines: 20,
                                    minLines: 10,
                                    validator: (value) {
                                      return value?.isNotEmpty != true
                                          ? 'Required field'
                                          : null;
                                    },
                                    decoration: const InputDecoration(
                                      label: Text('Comment'),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: canSubmitReview
                                  ? () async {
                                      if (state is LoadingState) return;

                                      await sendReviewMethod();
                                    }
                                  : null,
                              child: const Text(
                                'SUBMIT',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: state is LoadingState,
                  child: Container(
                    color: Colors.white38,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
