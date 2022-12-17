import 'package:coolmovies/core/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.id,
    required super.nodeId,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'id': id});
    result.addAll({'nodeId': nodeId});

    return result;
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      nodeId: map['nodeId'] ?? '',
    );
  }
}
