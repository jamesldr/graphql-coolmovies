abstract class BaseState {}

class LoadingState implements BaseState {
  const LoadingState();
}

class SuccessState<T> implements BaseState {
  final T data;

  const SuccessState(this.data);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuccessState<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class ErrorState implements BaseState {
  final String message;

  const ErrorState({this.message = 'Unknown Error, please try again later'});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class EmptyState implements BaseState {
  final String? message;

  const EmptyState({this.message});
}
