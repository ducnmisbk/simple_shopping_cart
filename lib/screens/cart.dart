import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:simple_shopping_cart/components/ProductListItem.dart';
import 'package:simple_shopping_cart/models/Cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headline1),
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: Theme.of(context).textTheme.headline1,
              ),
            )
          : SafeArea(
              child: Column(
                children: const [
                  Expanded(child: CartList()),
                  CartTotal(),
                ],
              ),
            ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (_, index) =>
            ProductListItem(cart.items[index], addButtonVisiable: false));
  }
}

class CartTotal extends StatelessWidget {
  const CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1!.copyWith(fontSize: 32);
    final cartProvider = Provider.of<CartModel>(context);

    return SizedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('Total:', style: hugeStyle)),
                Consumer<CartModel>(
                  builder: (context, cart, child) => Text(
                    '\$${cart.totalPrice}',
                    style: hugeStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.yellow,
                    child: TextButton(
                      onPressed: () {
                        try {
                          EasyLoading.show(
                            status: 'buying...',
                            maskType: EasyLoadingMaskType.black,
                          );
                          cartProvider.buy().then((value) {
                            EasyLoading.dismiss();
                            Navigator.pop(context);
                          });
                        } catch (err) {
                          EasyLoading.dismiss();
                        }
                      },
                      child: const Text('BUY'),
                      style: TextButton.styleFrom(
                          primary: Colors.black, textStyle: hugeStyle),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
