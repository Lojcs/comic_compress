extension ListGetCopyWith<T> on List<T> {
  List<T> Function(T value) getCopyWith(int i) =>
      (T value) => toList()..[i] = value;
  List<T> Function(T value) append() =>
      (T value) => toList()..add(value);
}
