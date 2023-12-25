typedef Dispatch<S, T> = S Function(T arg);
typedef Method<T, U> = U Function(T arg);

class Multimethod<S, T, U extends dynamic> {
  Multimethod({Dispatch<S, T>? dispatch, Map<S, Method<T, U>>? methods}) : _dispatch = dispatch {
    if (methods != null) _methods.addAll(methods);
  }

  Dispatch<S, T>? _dispatch;
  Method<T, U>? _default;

  final Map<S, Method<T, U>> _methods = {};

  Multimethod<S, T, U> dispatch(S Function(T arg) dispatch) {
    _dispatch = dispatch;
    return this;
  }

  Multimethod<S, T, U> defaultMethod(U Function(T arg) method) {
    _default = method;
    return this;
  }

  Multimethod<S, T, U> when(dynamic predicate, U Function(T arg) method) {
    _methods[predicate] = method;
    return this;
  }

  Multimethod<S, T, U> whenAny(Iterable<dynamic> predicates, U Function(T arg) method) {
    for (final predicate in predicates) {
      _methods[predicate] = method;
    }
    return this;
  }

  Multimethod<S, T, U> remove(dynamic predicate) {
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
