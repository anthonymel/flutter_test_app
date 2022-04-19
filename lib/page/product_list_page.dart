import 'package:flutter/material.dart';
import 'package:untitled/model/api/product_api.dart';
import 'package:untitled/model/entities/category.dart';
import 'package:untitled/model/entities/product.dart';
import 'package:untitled/view/product_list_item.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key, this.category})
      : super(
          key: key,
        );
  final Category? category;

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductApi productApi = ProductApi();
  final List<Product> productList = [];
  final bool isLoading = false;


  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var result = await productApi.fetchProducts(
        categoryId: widget.category?.categoryId,
        offset: productList.length
    );
    setState(() {
      productList.addAll(result);
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
      title: Text(widget.category == null ? 'Все товары' : widget.category!.title),
    );
  }

  Widget buildBody(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        var product = productList[index];
        return ProductListItem(
          product: product,
        );
      },
      itemCount: productList.length,
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
    );
  }
}
