import 'package:coolmovies/core/auth/data/models/user_model.dart';
import 'package:coolmovies/modules/home/domain/entities/movie_review.dart';

class MovieReviewModel extends MovieReview {
  const MovieReviewModel({
    super.id,
    super.body,
    super.title,
    super.rating,
    super.userReviewerId,
    super.nodeId,
    super.movieId,
    super.user,
  });
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (body != null) {
      result.addAll({'body': body});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (rating != null) {
      result.addAll({'rating': rating});
    }
    if (userReviewerId != null) {
      result.addAll({'userReviewerId': userReviewerId});
    }
    if (nodeId != null) {
      result.addAll({'nodeId': nodeId});
    }
    if (movieId != null) {
      result.addAll({'movieId': movieId});
    }

    return result;
  }

  factory MovieReviewModel.fromJson(Map<String, dynamic> map) {
    return MovieReviewModel(
      id: map['id'],
      body: map['body'],
      title: map['title'],
      rating: map['rating']?.toInt(),
      userReviewerId: map['userReviewerId'],
      nodeId: map['nodeId'],
      movieId: map['movieId'],
      user: UserModel.fromJson(map['userByUserReviewerId']),
    );
  }
}
