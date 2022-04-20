import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/model/entities/category.dart';
import 'package:untitled/page/product_list_page.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key? key,
    required this.category,
  }) : super(
          key: key,
        );

  final Category category;

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
              builder: (context) => ProductListPage(category: category),
            )
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (category.imageUrl?.isNotEmpty ?? false)
              Expanded(
                flex: 4,
                child: ExtendedImage.network(category.imageUrl!),
              ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              flex: 1,
              child: Text(
                category.title,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
