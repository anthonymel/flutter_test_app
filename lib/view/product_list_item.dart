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
    return buildProductItem(context);
  }

  Widget buildProductItem(context) {
    return Padding(
        padding: const EdgeInsets.only(
          bottom: 12,
        ),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.images?.isNotEmpty ?? false)
                buildCategoryImage(context),
              buildTitleBlock(context),
              buildCartPriceBlock(context),
            ],
          ),
        ));
  }

  Widget buildCategoryImage(context) {
    return Container(
      padding: EdgeInsets.all(24), // Border width
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(4, 2), // changes position of shadow
          ),
        ],
      ),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(36), // Image radius
          child: ExtendedImage.network(product.images!.first),
        ),
      ),
    );
  }

  Widget buildTitleBlock(context) {
    return Expanded(
      flex: 6,
      child: Center(child: Text(product.title)),
    );
  }

  Widget buildCartPriceBlock(context) {
    return Expanded(
      flex: 4,
      child: Center(
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(84, 24),
              backgroundColor: Colors.white,
            ),
            onPressed: () => onTapCartPrice(context),
            child: Text(product.price.toString() + " р")),
      ),
    );
  }

  onTapCartPrice(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: product),
        ));
  }
}
