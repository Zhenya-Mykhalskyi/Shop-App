import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/ordrers.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '\$${order.amount}',
                style: TextStyle(
                    fontSize: 16,
                    backgroundColor: Theme.of(context).backgroundColor),
              ),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy   hh:mm').format(order.dateTime),
              style: const TextStyle(fontSize: 12),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
