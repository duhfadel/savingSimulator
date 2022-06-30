import 'package:flutter/cupertino.dart';

class Balance extends ChangeNotifier {
  Balance({
    required this.value,
  });

  double get sumBalance => value;

  double value;

  void addMoney(double value) {
    this.value += value;
    notifyListeners();
  }

  @override
  String toString() {
    return '€ $value';
  }
}
