import 'package:flutter_bloc/flutter_bloc.dart';

typedef StateMutator<S> = S Function(S state);

/// Cubit with mutator access.
abstract class Mubit<T> extends Cubit<T> {
  new(super.initialState);
  void mutate(StateMutator<T> mutator) => emit(mutator(state));
}
