import 'package:flutter/material.dart';
import 'package:untitled/model/api/product_api.dart';
import 'package:untitled/model/entities/category.dart';
import 'package:untitled/model/entities/product.dart';
import 'package:untitled/view/product_list_item.dart';

import 'product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({
    Key? key,
    this.category,
  }) : super(
          key: key,
        );
  final Category? category;

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductApi productApi = ProductApi();
  final List<Product> productList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    reloadData();
  }

  Future<void> reloadData() async {
    productList.clear();
    _showLoading(context);
    loadNextData();
  }

  Future<void> loadNextData() async {
    var response = await productApi.loadProducts(
      categoryId: widget.category?.categoryId,
      offset: productList.length,
    );
    if (response.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.errorText ?? ""),
      ));
      return;
    }
    productList.addAll(response.result ?? []);
    _hideLoading(context);
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
      title:
          Text(widget.category == null ? 'Все товары' : widget.category!.title),
    );
  }

  Widget buildBody(BuildContext context) {
    if (isLoading) {
      return _buildLoading(context);
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {

        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          loadNextData();
        }
        return true;
      },
      child: _buildListView(context),
    );
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: reloadData,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(context, index);
        },
        itemCount: productList.length,
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    var product = productList[index];
    return InkWell(
      onTap: () => _onItemTap(product),
      child: ProductListItem(
        product: product,
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _onItemTap(Product product) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: product,
          ),
        ));
  }

  void _showLoading(BuildContext context) {
    if (productList.isEmpty) {
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
