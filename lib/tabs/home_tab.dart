import 'package:flutter/material.dart';
import 'package:remote_kitchen_quiz/api_helper.dart';
import 'package:remote_kitchen_quiz/cards/item_card.dart';
import 'package:remote_kitchen_quiz/models/menu_item.dart';

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
    return _isLoading
        ? Center(
            child: Container(
              height: 100,
              width: 100,
              child: const CircularProgressIndicator(),
            ),
          )
        : Container(
            color: Color.fromARGB(255, 243, 240, 240),
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, index) {
                return ItemCard1(
                    item: itemList[index], thisProductList: itemList);
              },
            ),
          );
  }
}
