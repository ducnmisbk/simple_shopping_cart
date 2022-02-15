import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../models/Cart.dart';
import '../models/Product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final bool addButtonVisiable;

  const ProductListItem(this.product,
      {required this.addButtonVisiable, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 72,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.green,
                child: Image(
                  image: NetworkImage(product.image),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: textTheme,
                    textWidthBasis: TextWidthBasis.longestLine,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${product.price}',
                    textAlign: TextAlign.left,
                    style: textTheme?.copyWith(color: Colors.red),
                    textWidthBasis: TextWidthBasis.longestLine,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            addButtonVisiable
                ? _AddButton(product: product)
                : _RemoveButton(product: product),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  Product? product;

  _AddButton({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);
    return TextButton(
      onPressed: () {
        try {
          EasyLoading.show(
            status: 'adding...',
            maskType: EasyLoadingMaskType.black,
          );
          cartProvider.add(product).then((value) {
            EasyLoading.dismiss();
            if (!value) {
              Fluttertoast.showToast(msg: 'Product already added');
            }
          });
        } catch (err) {
          EasyLoading.dismiss();
        }
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: const Text('ADD'),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  Product? product;

  _RemoveButton({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return TextButton(
      onPressed: () {
        if (product != null) {
          cart.remove(product!.id);
        }
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: const Text('REMOVE'),
    );
  }
}
