import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:simple_shopping_cart/models/Cart.dart';
import 'package:simple_shopping_cart/models/Product.dart';
import 'package:simple_shopping_cart/models/User.dart';
import 'package:simple_shopping_cart/provider/product_provider.dart';

import '../components/ProductListItem.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  void initState() {
    super.initState();
    final products = Provider.of<ProductProvider>(context, listen: false);
    try {
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      products.loadProducts().then((value) => EasyLoading.dismiss());
    } catch (err) {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CatalogAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  Product p = products.productList[index];
                  return ProductListItem(p, addButtonVisiable: true);
                },
                childCount: products.productList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CatalogAppBar extends StatelessWidget {
  const CatalogAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    return SliverAppBar(
      title: Text(
        'Catalog',
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
      floating: true,
      leading: IconButton(
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        icon: const Icon(Icons.shopping_cart_outlined),
      ),
      actions: [
        IconButton(
            onPressed: () {
              userProvider.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout)),
      ],
    );
  }
}
