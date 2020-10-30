import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransationList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransationList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty 
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma Transação Cadastrada!',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.60,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ]
              );
            },
          ) 
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
              elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text('R\$${tr.value}'),
                ),
              ),
            ),
            title: Text(
              tr.title,
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              DateFormat('d MMM y').format(tr.date),
            ),
            // Abaixo código para adaptação/responsiva ao dispositivo
            trailing: MediaQuery.of(context).size.width > 400
                ? FlatButton.icon(
                    onPressed: () => onRemove(tr.id),
                    icon: Icon(Icons.delete),
                    label: Text('Excluir'),
                    textColor: Theme.of(context).errorColor,
                  )
                : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => onRemove(tr.id),
                  ),
          ),
        );
      },
    );
  }
}
