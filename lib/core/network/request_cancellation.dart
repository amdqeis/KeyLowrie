abstract interface class CancellationSignal {
  bool get isCancelled;
  void onCancel(void Function() callback);
}

class RequestCancellation implements CancellationSignal {
  bool _cancelled = false;
  final List<void Function()> _callbacks = [];

  @override
  bool get isCancelled => _cancelled;

  @override
  void onCancel(void Function() callback) {
    if (_cancelled) {
      callback();
    } else {
      _callbacks.add(callback);
    }
  }

  void cancel() {
    if (_cancelled) return;
    _cancelled = true;
    for (final callback in List<void Function()>.of(_callbacks)) {
      callback();
    }
    _callbacks.clear();
  }
}
