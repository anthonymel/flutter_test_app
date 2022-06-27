import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/model/entities/product.dart';

import '../model/entities/cart.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(
          key: key,
        );

  final Product product;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.product.images?.isNotEmpty ?? false)
              _buildProductImage(context),
            _buildAddToCardAndPriceBlock(context),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12.0),
              child: Text(
                "Описание",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildProductDescription(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      child: Container(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: ExtendedImage.network(widget.product.images!.first),
        ),
      ),
    );
  }

  Widget _buildAddToCardAndPriceBlock(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.product.price.toString() + " р",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        _buildCartBlock(context),
      ],
    );
  }

  Widget _buildCartBlock(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            maximumSize: Size.fromHeight(40),
          ),
          onPressed: () {
            setState(() {
              if (cart.cartProducts.length > 0) {
                cart.removeFromCart(widget.product);
                var deleteIndex = cart.cartProducts.indexWhere((product) => product.productId == widget.product.productId);
                cart.cartProducts.removeAt(deleteIndex);
                log(cart.cartProducts.toString());
              }
            });
          },
          child: Center(child: Icon(Icons.remove)),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: 50,
            child: Center(
              child: Text(
                cart.cartProducts.length.toString() + " шт",
              ),
            ),
          ),
        ),
        ElevatedButton(
         style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            maximumSize: Size.fromHeight(40),
          ),
          onPressed: () {
            setState(() {
              cart.addToCart(widget.product);
              cart.cartProducts.add(widget.product);
              log(cart.cartProducts.toString());
            });
          },
          child: Center(child: Icon(Icons.add)),
        ),
      ],
    );
  }

  Widget _buildProductDescription(context) {
    return Container(
      child: Text(
        widget.product.description ??
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
