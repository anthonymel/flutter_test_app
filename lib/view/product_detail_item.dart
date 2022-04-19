import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/model/entities/product.dart';

class ProductDetailItem extends StatelessWidget {
  const ProductDetailItem({Key? key, required this.product}) : super(key: key);

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
            if (product.images?.isNotEmpty ?? false)
              Container(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: ExtendedImage.network(product.images!.first),
              )
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(product.price.toString() + " р"),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {},
                  child: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(product.description ?? 'Описание пока не завезли...'),
            )
          ],
        )
      ),
    );
  }
}
