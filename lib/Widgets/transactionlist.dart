// ignore_for_file: empty_constructor_bodies, unnecessary_new

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  // ignore: use_key_in_widget_constructors
  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrains) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: sized_box_for_whitespace, avoid_unnecessary_containers
                  Container(
                    height: constrains.maxHeight * 0.6,
                    child: Image.asset(
                      'images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : Expanded(
            child: SizedBox(
              height: 200.0,
              child: new ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 260
                          ?
                          // ignore: deprecated_member_use
                          FlatButton.icon(
                              // ignore: prefer_const_constructors
                              label: Text('Delete'),
                              icon: const Icon(Icons.delete),
                              textColor: Theme.of(context).errorColor,
                              onPressed: () => deleteTx(transactions[index].id),
                            )
                          : IconButton(
                              icon: const Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () => deleteTx(transactions[index].id),
                            ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ),
            ),
          );
  }
}
