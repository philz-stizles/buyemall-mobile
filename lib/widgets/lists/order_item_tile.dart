import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:intl/intl.dart';

class OrderItemTile extends StatefulWidget {
  final OrderItem orderItem;

  OrderItemTile({ @required this.orderItem });

  @override
  _OrderItemTileState createState() => _OrderItemTileState();
}

class _OrderItemTileState extends State<OrderItemTile> {
  var _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = widget.orderItem.cartItems;
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount.toStringAsFixed(2)}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.orderItem.createdAt)),
            trailing: IconButton(
              icon: Icon((_isExpanded) ? Icons.expand_less : Icons.expand_more),
              onPressed: () => _toggleExpanded(),
            ),
          ),
          if(_isExpanded) Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            height: min((cartItems.length * 20.0) + 10, 100),
            child: ListView(
              children: cartItems.map((item) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('${item.quantity}x \$${item.price}', style: TextStyle(fontSize: 18, color: Colors.grey))
                ],
              )).toList()
            )
          )
        ],
      ),
    );
  }
}