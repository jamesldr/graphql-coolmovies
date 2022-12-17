class ResponseWrapper<T> {
  final T? data;
  final String? errorMessage;

  const ResponseWrapper({
    this.data,
    this.errorMessage,
  }) : assert(
          (data != null && errorMessage == null) ||
              (data == null && errorMessage != null),
        );

  bool get isSuccess => data != null;
  bool get isError => errorMessage != null;
}
