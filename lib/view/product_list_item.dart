import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/model/entities/product.dart';

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
          if (product.images?.isNotEmpty ?? false)
            Flexible(
              flex: 1,
              child: Image.network(product.images!.first),
            ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            flex: 3,
            child: Text(product.title),
          ),
        ],
      ),
    );
  }
}
