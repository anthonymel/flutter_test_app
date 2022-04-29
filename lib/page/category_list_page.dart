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
    loadNextData();
  }

  Future<void> reloadData() async {
    categoryList.clear();
    _showLoading(context);
    loadNextData();
  }

  Future<void> loadNextData() async {
    _showLoading(context);
    var response = await categoryApi.loadCategories(
      offset: categoryList.length,
      parentId: widget.parentId,
    );
    if (response.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.errorText ?? ""),
      ));
      return;
    }
    categoryList.addAll(response.result ?? []);
    _hideLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Каталог'),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (isLoading) {
      return _buildLoading(context);
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        return false;
      },
      child: _buildGridView(context),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.blue,
      color: Colors.white,
      onRefresh: reloadData,
      child: GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _buildGridItem(context, index);
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
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    var category = categoryList[index];
    return InkWell(
      onTap: () => _onItemTap(category),
      child: CategoryListItem(
        category: category,
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _onItemTap(Category category) {
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

  void _showLoading(BuildContext context) {
    if (categoryList.isEmpty) {
      setState(() {
        isLoading = true;
      });
    }
  }

  void _hideLoading(BuildContext context) {
    setState(() {
      isLoading = false;
    });
  }
}
