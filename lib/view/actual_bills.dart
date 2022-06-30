import 'package:flutter/material.dart';
import 'package:need_dolar/model/bills.dart';
import 'package:provider/provider.dart';

class ActualBills extends StatelessWidget {
  const ActualBills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Bills>(
      builder: ((context, sum, child) {
        return Text(sum.toStringBillsum());
      }),
    );
  }
}
