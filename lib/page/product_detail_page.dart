import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/model/entities/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(
          key: key,
        );

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            if (product.images?.isNotEmpty ?? false) buildProductImage(context),
            buildAddToCardAndPriceBlock(context),
            const SizedBox(height: 12),
            buildProductDescription(context),
          ],
        ),
      ),
    );
  }

  Widget buildProductImage(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: ExtendedImage.network(product.images!.first),
        ),
      ),
    );
  }

  Widget buildAddToCardAndPriceBlock(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(product.price.toString() + " р"),
        const SizedBox(width: 12),
        OutlinedButton(
          onPressed: () {},
          child: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }

  Widget buildProductDescription(context) {
    return Expanded(
      child: Text(product.description ?? 'Описание пока не завезли...'),
    );
  }
}
