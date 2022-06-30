import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:need_dolar/main.dart';
import 'package:need_dolar/model/bill.dart';
import 'package:need_dolar/model/bills.dart';
import 'package:need_dolar/model/saving.dart';
import 'package:need_dolar/model/savings.dart';
import 'package:need_dolar/view/actual_bills.dart';
import 'package:need_dolar/view/actual_savings.dart';
import 'package:need_dolar/view/error.dart';
import 'package:need_dolar/view/resume.dart';
import 'package:provider/provider.dart';
import 'package:need_dolar/model/balance.dart';
import 'package:need_dolar/view/actual_balance.dart';

class Dashboard extends StatelessWidget {
  Dashboard({
    Key? key,
  }) : super(key: key);

  final TextEditingController _addMoneyController = TextEditingController();
  final TextEditingController _billNameController = TextEditingController();
  final TextEditingController _billAmountController = TextEditingController();
  final TextEditingController _savingNameController = TextEditingController();
  final TextEditingController _savingAmountController = TextEditingController();
  final TextEditingController _savingPercentController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    Balance balance = Provider.of<Balance>(context);
    Bills bills = Provider.of<Bills>(context);
    Savings savings = Provider.of<Savings>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            Column(children: [
              Positioned(
                top: 00,
                child: Container(
                  width: double.maxFinite,
                  height: 260,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your Balance: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Consumer<Balance>(
                                    builder: ((context, value, child) {
                                      return const ActualBalance();
                                    }),
                                  ),
                                ),
                                AddMoney(
                                  icon: Icons.monetization_on,
                                  text: 'Add',
                                  onTap: () {
                                    showPlatformDialog(
                                      context: context,
                                      builder: (context) => BasicDialogAlert(
                                        title: const Text(
                                            "How much are you adding?"),
                                        content: TextField(
                                          controller: _addMoneyController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              labelText: '€', prefixText: '€'),
                                        ),
                                        actions: <Widget>[
                                          BasicDialogAction(
                                            title: const Text("Cancel"),
                                            onPressed: () {
                                              _clearText();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          BasicDialogAction(
                                              title: const Text("OK"),
                                              onPressed: () {
                                                _addDeposit(context);
                                                _clearText();
                                              })
                                        ],
                                      ),
                                    );
                                  },
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AddButtons(
                                    icon: Icons.emoji_emotions,
                                    text: 'New Saving',
                                    onTap: () {
                                      showPlatformDialog(
                                          context: context,
                                          builder: (context) =>
                                              SingleChildScrollView(
                                                child: BasicDialogAlert(
                                                    content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                            "What's the Saving Name?"),
                                                        TextField(
                                                          maxLength: 14,
                                                          controller:
                                                              _savingNameController,
                                                          decoration:
                                                              const InputDecoration(),
                                                        ),
                                                        const Text(
                                                            'How much do you want to add on this saving?'),
                                                        TextField(
                                                          controller:
                                                              _savingAmountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText: '€',
                                                            prefixText: '€',
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                              'You can also add % of you want!'),
                                                        ),
                                                        ConstrainedBox(
                                                          constraints:
                                                              const BoxConstraints
                                                                      .tightFor(
                                                                  width: 80),
                                                          child: TextField(
                                                            controller:
                                                                _savingPercentController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        '%',
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    suffixText:
                                                                        '%'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: <Widget>[
                                                      BasicDialogAction(
                                                        title: const Text(
                                                            "Cancel"),
                                                        onPressed: () {
                                                          _clearText();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      BasicDialogAction(
                                                        title: const Text("Ok"),
                                                        onPressed: () {
                                                          _addSaving(context);
                                                          _clearText();
                                                        },
                                                      ),
                                                    ]),
                                              ));
                                    },
                                    color: Colors.green,
                                  ),
                                  AddButtons(
                                    icon: Icons.dangerous,
                                    text: 'New Bill',
                                    onTap: () {
                                      showPlatformDialog(
                                          context: context,
                                          builder: (context) =>
                                              BasicDialogAlert(
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                            "What's the Bill Name?"),
                                                        TextField(
                                                          maxLength: 14,
                                                          controller:
                                                              _billNameController,
                                                        ),
                                                        const Text(
                                                            'How much does it cost per month?'),
                                                        TextField(
                                                          controller:
                                                              _billAmountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      '€',
                                                                  prefixText:
                                                                      '€'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    BasicDialogAction(
                                                      title:
                                                          const Text("Cancel"),
                                                      onPressed: () {
                                                        _clearText();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    BasicDialogAction(
                                                      title: const Text("Ok"),
                                                      onPressed: () {
                                                        _addBill(context);
                                                        _clearText();
                                                      },
                                                    )
                                                  ]));
                                    },
                                    color: Colors.red,
                                  ),
                                ]),
                          ])),
                ),
              ),
            ]),
          ]),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Divider(
              height: 3,
              color: Colors.grey,
            ),
          ),
          const Center(
            child: ActualBills(),
          ),
          SizedBox(
            height: 140,
            width: double.infinity,
            child: Consumer<Bills>(
              builder: ((context, bills, child) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: bills.bills.length,
                    itemBuilder: (context, index) {
                      final bill = bills.bills[index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AddBillsSavings(
                            text: bill.text,
                            icon: Icons.dangerous,
                            color: Colors.red,
                            onTap: () {
                              showPlatformDialog(
                                context: context,
                                builder: (context) => BasicDialogAlert(
                                  title: const Text('Do you want to delete?'),
                                  actions: <Widget>[
                                    BasicDialogAction(
                                      title: const Text("Cancel"),
                                      onPressed: () {
                                        _clearText();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    BasicDialogAction(
                                      title: const Text("Delete"),
                                      onPressed: () {
                                        _removeBill(context, index, bill);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            value: bill.value.toString(),
                          ));
                    });
              }),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Divider(
              height: 3,
              color: Colors.grey,
            ),
          ),
          const Center(
            child: ActualSavings(),
          ),
          SizedBox(
              height: 140,
              width: double.infinity,
              child: Consumer<Savings>(builder: ((context, savings, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: savings.savings.length,
                  itemBuilder: (context, index) {
                    final saving = savings.savings[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AddBillsSavings(
                        text: saving.text,
                        icon: Icons.emoji_emotions,
                        color: Colors.green,
                        value: saving.toStringValue(),
                        onTap: () {
                          showPlatformDialog(
                            context: context,
                            builder: (context) => BasicDialogAlert(
                                title: const Text('Do you want to delete?'),
                                actions: <Widget>[
                                  BasicDialogAction(
                                    title: const Text("Cancel"),
                                    onPressed: () {
                                      _clearText();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  BasicDialogAction(
                                      title: const Text("Delete"),
                                      onPressed: () {
                                        _removeSaving(context, index, saving);
                                      })
                                ]),
                          );
                        },
                      ),
                    );
                  },
                );
              })))
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black87,
        child: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      resetApp();
                    },
                    icon: const Icon(Icons.restart_alt_rounded),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      _validateTotal(balance, bills, savings, context);
                    },
                    child: const Text(
                      'Press for Calcs',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void _removeSaving(BuildContext context, int index, Saving saving) {
    Provider.of<Savings>(context, listen: false).removeSaving(index, saving);
    Navigator.pop(context);
    _clearText();
  }

  void _removeBill(BuildContext context, int index, Bill bill) {
    Provider.of<Bills>(context, listen: false).removeBill(index, bill);
    Navigator.pop(context);
    _clearText();
  }

  _addDeposit(context) {
    double? value = double.tryParse(_addMoneyController.text);
    final validDeposit = _validateDeposit(value);
    if (validDeposit) {
      _updateDeposit(context, value);
      Navigator.pop(context);
    }
  }

  _validateDeposit(value) {
    final fulledField = value != null;
    return fulledField;
  }

  _updateDeposit(context, value) {
    Provider.of<Balance>(context, listen: false).addMoney(value);
  }

  _addBill(context) {
    final String text = _billNameController.text;
    final double value = double.parse(_billAmountController.text);
    final validateBill = _validateBill(text, value);
    if (validateBill) {
      final newBill = Bill(text: text, value: value);
      updateBill(context, newBill);
      Navigator.pop(context);
    }
  }

  _validateBill(text, value) {
    final fieldFilled = text != null && value != null;
    return fieldFilled;
  }

  updateBill(context, newBill) {
    Provider.of<Bills>(context, listen: false).addBill(newBill);
  }

  _addSaving(context) {
    String text = _savingNameController.text;
    double value;
    double percentual;
    if (_savingAmountController.text.isEmpty) {
      _savingAmountController.text = '0';
    }
    value = double.parse(_savingAmountController.text);

    if (_savingPercentController.text.isEmpty) {
      _savingPercentController.text = '0';
    }
    percentual = double.parse(_savingPercentController.text);
    final validateSaving = _validateSaving(text, value, percentual);
    if (validateSaving) {
      final newSaving =
          Saving(text: text, value: value, percentual: percentual);
      updateSaving(context, newSaving);
      Navigator.pop(context);
    }
  }

  _validateSaving(text, value, percentual) {
    final fieldFilled = text != null && (value != 0 || percentual != 0);
    return fieldFilled;
  }

  updateSaving(context, newSaving) {
    Provider.of<Savings>(context, listen: false).addSaving(newSaving);
  }

  void _clearText() {
    _billAmountController.clear();
    _billNameController.clear();
    _savingAmountController.clear();
    _savingNameController.clear();
    _addMoneyController.clear();
    _savingPercentController.clear();
  }

  _validateTotal(Balance balance, Bills bills, savings, context) {
    double total = balance.value;
    double totalDebts = bills.sumBills + savings.sumSavings;
    if (total >= totalDebts && savings.savingsperCent <= 100) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Resume()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ErrorPage()));
    }
  }
}

class AddButtons extends StatelessWidget {
  const AddButtons(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onTap,
      required this.color})
      : super(key: key);

  final String text;
  final IconData icon;
  final void Function() onTap;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 10, 4),
      child: Material(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ]),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(children: [
                Icon(
                  icon,
                  color: Colors.grey[300],
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Center(
                      child: Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class AddBillsSavings extends StatelessWidget {
  const AddBillsSavings(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onTap,
      required this.color,
      required this.value})
      : super(key: key);

  final String text;
  final IconData icon;
  final void Function() onTap;
  final MaterialColor color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 10, 20),
      child: Material(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 100,
            height: 90,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ]),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(children: [
                Icon(
                  icon,
                  color: Colors.grey[300],
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5),
                  child: Center(
                      child: Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ),
                Text(
                  value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class AddMoney extends StatelessWidget {
  const AddMoney(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onTap,
      required this.color})
      : super(key: key);

  final String text;
  final IconData icon;
  final void Function() onTap;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 10, 15),
      child: Material(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 80,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Icon(
                  icon,
                  color: Colors.grey[300],
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                      child: Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
