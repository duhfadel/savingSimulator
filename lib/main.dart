import 'dart:async';

import 'package:flutter/material.dart';
import 'package:need_dolar/model/balance.dart';
import 'package:need_dolar/model/bills.dart';
import 'package:need_dolar/model/savings.dart';
import 'package:need_dolar/view/dashboard.dart';
import 'package:provider/provider.dart';

StreamController<int> _resetApp = StreamController();
int _resetCounter = 0;

void resetApp() {
  _resetApp.add(++_resetCounter);
}

void main() {
  runApp(
    StreamBuilder<int>(
                stream: _resetApp.stream,
                initialData: 0,
                builder: (context, snapshot) {
        return MultiProvider(
          key: ValueKey(snapshot.data),
          providers: [
            ChangeNotifierProvider(create: ((context) => Balance(value: 0))),
            ChangeNotifierProvider(create: ((context) => Bills(sum: 0))),
            ChangeNotifierProvider(create: ((context) => Savings(sum: 0))),
          ],
          child: MaterialApp(
            theme: ThemeData(),
            home:  Dashboard()
          ),
        );
      }
    ),
  );
}
