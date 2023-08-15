import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_kitchen_quiz/api_helper.dart';
import 'package:remote_kitchen_quiz/cards/item_card.dart';
import 'package:remote_kitchen_quiz/models/menu_item.dart';
import 'package:remote_kitchen_quiz/providers/item_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _isLoading = false;
  List<MenuItem> itemList = [];

  void getItemList() async {
    setState(() {
      _isLoading = true;
    });
    itemList = await ApiHelper.instance.getMenuItems();
    // productList.shuffle();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> itemListInCart =
        Provider.of<ItemBloc>(context).itemListInCart;
    return _isLoading
        ? Center(
            child: Container(
              height: 100,
              width: 100,
              child: const CircularProgressIndicator(),
            ),
          )
        : Container(
            color: const Color.fromARGB(255, 243, 240, 240),
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, index) {
                MenuItem singleItem =
                    // ProductList().products[index];s
                    itemList[index];
                List<MenuItem> thisItemList = itemListInCart
                    .where((item) => item.id == singleItem.id)
                    .toList();
                return ItemCard1(
                    item: itemList[index], thisItemList: thisItemList);
              },
            ),
          );
  }
}
