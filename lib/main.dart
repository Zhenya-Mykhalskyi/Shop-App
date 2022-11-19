// ignore_for_file: missing_required_param

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../providers/ordrers.dart';
import '../screens/user_products_screen.dart';
import '../screens/edit_proruct_screen.dart';
import '../screens/auth_screen.dart';
import '../providers/auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProduts) => Products(
            auth.token,
            auth.userId,
            previousProduts == null ? [] : previousProduts.items,
          ),
        ), //proxy для того, щоб управляти токеном з файлу Auth. При зміні Auth буде створений новий об'єкт Products
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders)),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop',
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.lightGreen)
                    .copyWith(secondary: Colors.green),
          ),
          home:
              auth.isAuth ? const ProductsOverviewScreen() : const AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            OrdersScreen.routeName: (ctx) => const OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => const EditProductScreen(),
          },
        ),
      ),
    );
  }
}
