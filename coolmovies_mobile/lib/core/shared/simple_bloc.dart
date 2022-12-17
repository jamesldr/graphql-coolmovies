import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBloc<T> extends Cubit<T> {
  SimpleBloc(T initialValue) : super(initialValue);

  void call(T value) => emit(value);
}
