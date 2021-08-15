import 'package:flutter/material.dart';
import 'package:second_app/Widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

// ignore: use_key_in_widget_constructors
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  // ignore: use_key_in_widget_constructors
  const Chart(this.recentTransactions);

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalsum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalsum += recentTransactions[i].amount;
        }
      }
      // ignore: avoid_print
      print(DateFormat.E().format(weekDay));
      // ignore: avoid_print
      print(totalsum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(groupedTransactionValues);
    // ignore: sized_box_for_whitespace
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      // ignore: prefer_const_literals_to_create_immutables
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // ignore: prefer_const_literals_to_create_immutables
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                (totalSpending == 0
                    ? 0
                    : (data["amount"] as double) / totalSpending),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
