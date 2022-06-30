import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:need_dolar/model/saving.dart';
import 'package:provider/provider.dart';
import 'package:need_dolar/model/balance.dart';
import 'package:need_dolar/model/bills.dart';
import 'package:need_dolar/model/savings.dart';

class Resume extends StatelessWidget {
  const Resume({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Balance balance = Provider.of<Balance>(context);
    Bills bills = Provider.of<Bills>(context);
    Savings savings = Provider.of<Savings>(context);
    double newBalance = balance.value;
    double rest = (balance.value - (savings.sumSavings + bills.sumBills));
    List<Saving> savingWithoutPercentage =
        savings.savings.where((saving) => saving.percentual == 0).toList();
    List<Saving> savingWithPercentage =
        savings.savings.where((saving) => saving.percentual != 0).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: DottedBorder(
          child: SingleChildScrollView(
            child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text(
                          'Your inicial balance for this calculation was: $balance',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: bills.bills.length,
                          itemBuilder: (context, index) {
                            final bill = bills.bills[index];
                            validateBills() {
                              if (newBalance >= bill.value) {
                                newBalance -= bill.value;
                                return '€$newBalance';
                              } else {
                                bill.value = newBalance;
                                return '€$bill.value';
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      'You should pay bill: ${bill.text}, for €${bill.value}.',
                                      style: const TextStyle(fontSize: 20)),
                                  Text(validateBills()),
                                ],
                              ),
                            );
                          }),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: savingWithoutPercentage.length,
                          itemBuilder: (context, index) {
                            final saving = savingWithoutPercentage[index];
                            validateSavings() {
                              if (newBalance >= saving.value!) {
                                newBalance -= saving.value!;
                                return '€$newBalance';
                              } else {
                                saving.value = newBalance;
                                return '€$saving.value';
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      'You can add for saving: ${saving.text}, the amount of €${saving.value}.',
                                      style: const TextStyle(fontSize: 20)),
                                  Text(validateSavings()),
                                ],
                              ),
                            );
                          }),
                      const Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: savingWithPercentage.length,
                          itemBuilder: (context, index) {
                            final saving = savingWithPercentage[index];
                            double newValue = (saving.value! +
                                (rest / 100) * saving.percentual!);
                            validateSavingsPercent() {
                              if (newBalance >= newValue) {
                                newBalance -= newValue;
                                return 'You still have in your wallet €$newBalance';
                              } else {
                                saving.value = newBalance;
                                return '$newValue';
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      'You can add for saving: ${saving.text}, the amount of €$newValue.',
                                      style: const TextStyle(fontSize: 20)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      validateSavingsPercent(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
