import 'package:flutter/cupertino.dart';

import 'package:need_dolar/model/saving.dart';

class Savings extends ChangeNotifier {
  Savings({
    required this.sum,
  });
  List<Saving> _savings = [];

  double perCent = 0;
  double sum;
  double get sumSavings => sum;
  double get savingsperCent => perCent;

  List<Saving> get savings => _savings;

  void addSaving(Saving saving) {
    _savings.add(saving);
    sum += saving.value!;
    perCent += saving.percentual!;
    notifyListeners();
  }

  void removeSaving(index, saving) {
    _savings.removeAt(index);
    sum -= saving.value!;
    perCent -= saving.percentual!;
    notifyListeners();
  }

  String toStringSavingSum() {
    return 'Total amount of Savings: $sum';
  }
}
