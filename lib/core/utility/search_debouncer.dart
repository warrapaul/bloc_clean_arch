import 'dart:async';

class SearchDebouncer {
  final Duration delay;
  Timer? _timer;

  SearchDebouncer({required this.delay});

  Future<void> run(Future<void> Function() callback) async {
    _timer?.cancel();
    final completer = Completer<void>();
    _timer = Timer(delay, () async {
      await callback();
      completer.complete();
    });
    return completer.future;
  }

  void cancel() {
    _timer?.cancel();
  }
}
