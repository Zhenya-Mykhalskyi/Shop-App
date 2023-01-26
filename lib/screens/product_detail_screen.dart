import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;
  // ProductDetailScreen(this.title, this.price);

  static const routeName = 'product-detail';

  const ProductDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final deviceSize = MediaQuery.of(context).size;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      // appBar: MyAppBar(
      //   title: loadedProduct.title,
      //   actions: Container(),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn.shopify.com/s/files/1/0512/2542/8161/products/mothers-day-selection-box-exoticfruitscouk-192513_1024x1024@2x.jpg?v=1645776779'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
                FlexibleSpaceBar(
                  title: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Theme.of(context).colorScheme.background,
                    child: Text(
                      loadedProduct.title,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 34, 34, 34),
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          fontFamily: 'Anton'),
                    ),
                  ),
                  background: Hero(
                    tag: loadedProduct.id,
                    child: Image.network(
                      loadedProduct.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            expandedHeight: deviceSize.height / 2.3,
            pinned: true,
            //appBar always be visible when we scroll
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              Text(
                '\$${loadedProduct.price}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 82, 211, 2),
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              const SizedBox(
                height: 1000,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
