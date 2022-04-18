import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/model/entities/category.dart';

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (category.imageUrl?.isNotEmpty ?? false)
            Flexible(
              flex: 1,
              child: Image.network(category.imageUrl!),
            ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            flex: 2,
            child: Text(
              category.title,
            ),
          ),
        ],
      ),
    );
  }
}
