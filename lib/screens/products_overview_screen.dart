// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/my_appbar.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //future з затримкою, але виконується зразу, бо затримка нульова
    Provider.of<Products>(context, listen: false).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //запускається після повної ініціалізації віджета. Може запускатися декілька разів, а не один як initState
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Exotic Fruits Shop',
        // style: TextStyle(
        //     fontFamily: 'Anton', color: Color.fromARGB(232, 255, 255, 255)),
        actions: Row(
          children: [
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  setState(() {
                    if (selectedValue == FilterOptions.Favorites) {
                      _showOnlyFavorites = true;
                    } else {
                      _showOnlyFavorites = false;
                    }
                  });
                },
                itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: FilterOptions.Favorites,
                        child: Text(
                          'Only Favorites',
                        ),
                      ),
                      const PopupMenuItem(
                        value: FilterOptions.All,
                        child: Text(
                          'Show All',
                        ),
                      )
                    ],
                icon: const Icon(
                  Icons.more_vert,
                )),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                value: cart.itemCount.toString(),
                child: ch,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
