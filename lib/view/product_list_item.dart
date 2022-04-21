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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.images?.isNotEmpty ?? false) buildCategoryImage(context),
          const SizedBox(
            width: 12,
          ),
          buildTitleBlock(context),
          const SizedBox(
            width: 24,
          ),
          buildCartPriceBlock(context),
        ],
      ),
    );
  }

  Widget buildCategoryImage(context) {
    return Expanded(
      flex: 2,
      child: ExtendedImage.network(product.images!.first),
    );
  }

  Widget buildTitleBlock(context) {
    return Expanded(
      flex: 5,
      child: Text(product.title),
    );
  }

  Widget buildCartPriceBlock(context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(84, 24)),
              onPressed: () => onTapCartPrice(context),
              child: Text(product.price.toString() + " р")),
        ]);
  }

  onTapCartPrice(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: product),
        ));
  }
}
