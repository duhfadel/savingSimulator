import 'package:flutter/material.dart';
import 'package:need_dolar/model/savings.dart';
import 'package:provider/provider.dart';

class ActualSavings extends StatelessWidget {
  const ActualSavings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Savings>(
      builder: ((context, savings, child) {
        return Text(savings.toStringSavingSum());
      }),
    );
  }
}
