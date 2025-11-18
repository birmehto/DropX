import 'dart:async';

/// A utility class for debouncing function calls
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  /// Runs the action after the specified delay
  /// If called again before the delay expires, the previous call is cancelled
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancels any pending action
  void cancel() {
    _timer?.cancel();
  }

  /// Disposes the debouncer
  void dispose() {
    _timer?.cancel();
  }
}
