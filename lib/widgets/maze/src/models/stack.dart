import 'dart:collection';
import 'dart:core' as core;
import 'dart:core';

class Stack<T> {
  final ListQueue<T> _list = ListQueue();

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  void push(T e) {
    _list.addLast(e);
  }

  T pop() {
    final res = _list.last;
    _list.removeLast();
    return res;
  }

  T top() {
    return _list.last;
  }

  int size() {
    return _list.length;
  }

  int get length => size();

  bool contains(T x) {
    for (var item in _list) {
      if (x == item) {
        return true;
      }
    }
    return false;
  }

  void print() {
    for (var item in List<T>.from(_list).reversed) {
      core.print(item);
    }
  }
}