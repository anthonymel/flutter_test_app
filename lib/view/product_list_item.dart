import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/model/entities/product.dart';
import 'package:untitled/page/product_detail_page.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key? key,
    required this.product,
  }) : super(
          key: key,
        );

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            )
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images?.isNotEmpty ?? false)
              Expanded(
                flex: 2,
                child: ExtendedImage.network(product.images!.first),
              ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 5,
              child: Text(product.title),
            ),
            const SizedBox(
              width: 24,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center, children: [
              OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(84, 24)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      )
                  );
                },
                child: Text(product.price.toString() + " р")),
            ]),
          ],
        ),
      )
    );
  }
}
