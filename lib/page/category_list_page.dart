import 'package:flutter/material.dart';
import 'package:untitled/model/api/category_api.dart';
import 'package:untitled/model/entities/category.dart';
import 'package:untitled/view/category_list_item.dart';

import 'product_list_page.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({Key? key, this.parentId})
      : super(
          key: key,
        );
  final int? parentId;

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final CategoryApi categoryApi = CategoryApi();
  final List<Category> categoryList = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    if (categoryList.isEmpty) {
      setState(() {
        isLoading = true;
      });
    }
    var result = await categoryApi.loadCategories(
      offset: categoryList.length,
      parentId: widget.parentId,
    );
    setState(() {
      isLoading = false;
      categoryList.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Каталог'),
    );
  }

  Widget buildBody(BuildContext context) {
    if (isLoading) {
      return buildLoading(context);
    }
    return GridView.builder(
      itemBuilder: (BuildContext context, int index) {
        var category = categoryList[index];
        return InkWell(
          onTap: () => onItemTap(category),
          child: CategoryListItem(
            category: category,
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 24,
      ),
      itemCount: categoryList.length,
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
    );
  }

  Widget buildLoading(context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  onItemTap(Category category) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => category.hasSubcategories == 0
                ? ProductListPage(
                    category: category,
                  )
                : CategoryListPage(
                    parentId: category.categoryId,
                  )));
  }
}
