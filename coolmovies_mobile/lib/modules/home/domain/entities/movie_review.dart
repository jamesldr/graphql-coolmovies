import 'package:coolmovies/core/auth/domain/entities/user.dart';

class MovieReview {
  final String? id;
  final String? body;
  final String? title;
  final int? rating;
  final String? userReviewerId;
  final String? nodeId;
  final String? movieId;
  final User? user;

  const MovieReview({
    this.id,
    this.body,
    this.title,
    this.rating,
    this.userReviewerId,
    this.nodeId,
    this.movieId,
    this.user,
  });

  MovieReview setUser(User user) {
    return MovieReview(
      id: id,
      body: body,
      title: title,
      rating: rating,
      userReviewerId: user.id,
      nodeId: nodeId,
      movieId: movieId,
      user: user,
    );
  }

  @override
  String toString() {
    return '''
      {
        title: "$title"
        movieId: "$movieId"
        userReviewerId: "$userReviewerId"
        body: "$body"
        rating: $rating
      }
    ''';
  }
}
