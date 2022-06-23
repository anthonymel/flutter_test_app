import 'package:flutter/material.dart';
import 'package:untitled/model/api/product_api.dart';
import 'package:untitled/model/entities/category.dart';
import 'package:untitled/model/entities/product.dart';
import 'package:untitled/view/product_list_item.dart';

import 'product_detail_page.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _CartListPageState createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  final ProductApi productApi = ProductApi();
  final List<Product> productList = [];
  bool isLoading = false;
  num? cartPrice = 0;

  @override
  void initState() {
    super.initState();
    _showLoading(context);
    loadCartData();
  }

  Future<void> loadCartData() async {
    var cartResponse = await productApi.getCartPrice(productIds: [
      {"productId": "7348", "itemCount": 1}
    ]);
    if (cartResponse.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(cartResponse.errorText ?? ""),
      ));
      return;
    }

    setState(() {
      cartPrice = cartResponse.result;
    });

    var productListResponse =
        await productApi.loadProductsInCart(productIds: [7293, 7348]);
    if (productListResponse.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(productListResponse.errorText ?? ""),
      ));
      return;
    }
    productList.clear();
    productList.addAll(productListResponse.result ?? []);
    _hideLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
      bottomSheet: _buildCartPriceBlock(context),
    );
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Корзина'),
    );
  }

  Widget buildBody(BuildContext context) {
    if (isLoading) {
      return _buildLoading(context);
    }
    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      child: Column(
        children: [
          // _buildCartPriceBlock(context),
          Expanded(
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
          )
        ],
      ),
      onRefresh: _reloadData,
    );
  }

  Future<void> _reloadData() async {
    _showLoading(context);
    productList.clear();
    loadCartData();
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

  Widget _buildCartPriceBlock(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
      ),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
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
        child: Center(
            child: Text(
                "Стоимость корзины: " + cartPrice.toString() + " руб",
                style: Theme.of(context).textTheme.headline5)),
      ),
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
    // if (productList.isEmpty) {
    setState(() {
      isLoading = true;
    });
    // }
  }

  void _hideLoading(BuildContext context) {
    setState(() {
      isLoading = false;
    });
  }
}
