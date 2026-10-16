extension Reverse<R, A, T> on R Function(T t) Function(A a) {
  /// The reverse invocation of a chained function call.
  R Function(A a) Function(T t) get reverse =>
      (t) =>
          (a) => call(a)(t);
}

extension At<R, T> on R Function(T t) {
  /// Calls the function with the result of calling [m] on an incoming [s].
  R Function(S s) at<S>(T Function(S s) m) =>
      (s) => call(m(s));
}

extension By<R, T, A> on R Function(T Function(A a) t) {
  /// Calls the function with the result of
  /// calling the reverse of [m] on an incoming [s].
  R Function(S s) by<S>(T Function(S s) Function(A a) m) => at(m.reverse);
  // (s) => call((a) => m(a)(s));
}
