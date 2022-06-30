import 'package:flutter/cupertino.dart';

import 'package:need_dolar/model/bill.dart';

class Bills extends ChangeNotifier {
  final List<Bill> _bills = [];
  double sum;

  Bills({
    required this.sum,
  });

  List<Bill> get bills => _bills;
  double get sumBills => sum;

  addBill(Bill bill) {
    bills.add(bill);
    sum += bill.value;
    notifyListeners();
  }

  void removeBill(index, bill) {
    _bills.removeAt(index);
    sum -= bill.value!;
    notifyListeners();
  }

  String toStringBillsum() {
    return 'Total amount of Bills $sum';
  }
}
