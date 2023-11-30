class Multimethod<T, U extends dynamic> {
  Multimethod([this._dispatch]);

  dynamic Function(T)? _dispatch;
  U Function(T)? _default;

  final Map<dynamic, U Function(T)> _methods = {};

  Multimethod<T, U> dispatch(dynamic Function(T arg) dispatch) {
    _dispatch = dispatch;
    return this;
  }

  Multimethod<T, U> defaultMethod(U Function(T arg) method) {
    _default = method;
    return this;
  }

  Multimethod<T, U> when(dynamic predicate, U Function(T arg) method) {
    _methods[predicate] = method;
    return this;
  }

  Multimethod<T, U> whenAny(Iterable<dynamic> predicates, U Function(T arg) method) {
    for (final predicate in predicates) {
      _methods[predicate] = method;
    }
    return this;
  }

  Multimethod<T, U> remove(dynamic predicate) {
    _methods.remove(predicate);
    return this;
  }

  U call(T value) {
    final method = _methods[_dispatch?.call(value) ?? value];
    if (method == null) {
      if (_default == null) {
        throw ArgumentError('No method found for $value');
      }
      return _default!(value);
    }
    return method(value);
  }
}
