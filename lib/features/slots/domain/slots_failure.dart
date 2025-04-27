class SlotsFailure {
  final String message;

  const SlotsFailure(this.message);

  @override
  String toString() {
    return 'SlotFailure: $message';
  }
}