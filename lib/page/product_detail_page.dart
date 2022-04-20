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
    //TODO: update layout
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            if (product.images?.isNotEmpty ?? false)
              //TODO: move to buildProductImage(context)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: ExtendedImage.network(product.images!.first),
                  ),
                ),
              ),
            //TODO: move to buildAddToCardAndPriceBlock(context)
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
            //TODO: move to buildProductDescription(context)
            Expanded(
              child: Text(product.description ?? 'Описание пока не завезли...'),
            )
          ],
        ),
      ),
    );
  }
}
