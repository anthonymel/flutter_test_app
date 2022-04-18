import 'package:flutter/material.dart';
import 'package:untitled/model/api/category_api.dart';
import 'package:untitled/model/entities/category.dart';
import 'package:untitled/view/category_list_item.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final CategoryApi categoryApi = CategoryApi();
  final List<Category> categoryList = [];
  final bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var result = await categoryApi.fetchCategories(
      offset: categoryList.length,
    );
    setState(() {
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
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        var category = categoryList[index];
        return CategoryListItem(
          category: category,
        );
      },
      itemCount: categoryList.length,
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
    );
  }
}
