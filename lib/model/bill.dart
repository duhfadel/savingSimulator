class Bill {
  Bill({
    required this.text,
    required this.value,
  });

  String text;
  double value;

  String toStringText() {
    return text;
  }

  String toStringValue() {
    return '$value';
  }
}
