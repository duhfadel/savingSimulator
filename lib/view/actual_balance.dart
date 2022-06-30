import 'package:flutter/material.dart';
import 'package:need_dolar/model/balance.dart';
import 'package:provider/provider.dart';

class ActualBalance extends StatelessWidget {
  const ActualBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Balance >(
      builder: ((context, value, child) {
        return Text(
          value.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 40),
        );
      }),
    );
  }
}
