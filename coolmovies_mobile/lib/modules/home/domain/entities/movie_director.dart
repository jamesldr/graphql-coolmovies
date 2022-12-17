class MovieDirector {
  final String id;
  final String name;
  final int age;
  final String nodeId;
  MovieDirector({
    required this.id,
    required this.name,
    required this.age,
    required this.nodeId,
  });

  @override
  String toString() {
    return 'MovieDirectorById(id: $id, name: $name, age: $age, nodeId: $nodeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieDirector &&
        other.id == id &&
        other.name == name &&
        other.age == age &&
        other.nodeId == nodeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ age.hashCode ^ nodeId.hashCode;
  }
}
