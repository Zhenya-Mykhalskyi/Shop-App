import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/ordrers.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

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
                '\$${widget.order.amount.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 16,
                    backgroundColor: Theme.of(context).backgroundColor),
              ),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy   hh:mm').format(widget.order.dateTime),
              style: const TextStyle(fontSize: 12),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              height: min(widget.order.products.length * 20.0 + 25, 100),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prod.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${prod.quantity} kg  x  \$${prod.price}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
