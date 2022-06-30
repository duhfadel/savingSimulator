class Saving {
  Saving({
    required this.text,
    required this.value,
    required this.percentual,
  });

  String text;
  double? value = 0;
  double? percentual = 0;

  String toStringText() {
    return text;
  }

  String toStringValue() {
    return '$value, $percentual%';
  }
}
