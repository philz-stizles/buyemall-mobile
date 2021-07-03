import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/providers/providers.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final String productId;

  CartItemTile({@required this.cartItem, this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('No')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Yes'))
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItemFromCart(productId); // Ensure to set listen: false
        // as we only need the removeItemFromCart() method and do not intend to listen for state changes
      },
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: const EdgeInsets.only(right: 20.0),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(child: Text('\$${cartItem.price}')),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text('Total: \$${cartItem.quantity * cartItem.price}'),
            trailing: Text('${cartItem.quantity} x'),
          ),
        ),
      ),
    );
  }
}
