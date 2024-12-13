// class to manage state and notify listeners
import 'package:flutter/foundation.dart';

class SimpleState<T> extends ChangeNotifier implements ValueListenable<T> {
  T _state;

  SimpleState(this._state);

  @override
  T get value => _state;

  T get state => _state;
  T reset() {
    if (_state is num) {
      _state = 0 as T;
      notifyListeners();
    }
    return _state;
  }

  set state(T value) {
    if (_state != value) {
      _state = value;
      notifyListeners();
    }
  }
}
