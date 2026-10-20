import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/mubit.dart';

typedef ValueSelector<S, T> = T Function(S state);
typedef ValueCopyWith<T, V> = T Function(V value);
typedef GetCopyWith<S, V> = ValueSelector<S, ValueCopyWith<S, V>>;
typedef ApplyMutator<S, V> = ValueCopyWith<StateMutator<S>, V>;

/// Widget to provide a mubit with covenience methods.
abstract class ProvidingWidget<C extends Mubit<S>, S> extends StatelessWidget {
  final C cubit;
  const ProvidingWidget({super.key, required this.cubit});

  /// Gets the cubit state.
  S getValue() => cubit.state;
}

/// Widget to select from a mubit recursively with convenience methods.
abstract class SelectingWidget<C extends Mubit<S>, S, T>
    extends StatelessWidget {
  final ValueSelector<S, T> selector;
  final ValueChanged<T> valueChanged;
  const SelectingWidget({
    super.key,
    required this.selector,
    required this.valueChanged,
  });

  T value(BuildContext context) => selector(context.read<C>().state);
  T val(BuildContext context) => selector(context.read<C>().state);
}
