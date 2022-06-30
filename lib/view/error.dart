import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: const [
                Icon(
                  Icons.warning,
                  size: 70,
                ),
                Text(
                  'Please, double check your data!',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text(
                    'You are adding a % bigger than 100% or you don\'t have enough money to pay your bills',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
