// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_kitchen_quiz/api_helper.dart';
import 'package:remote_kitchen_quiz/cards/item_card.dart';
import 'package:remote_kitchen_quiz/models/menu_item.dart';
import 'package:remote_kitchen_quiz/pages/cart_page.dart';
import 'package:remote_kitchen_quiz/providers/item_bloc.dart';
import 'package:remote_kitchen_quiz/utils/next_screen.dart';

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

    int cartItemCount = Provider.of<ItemBloc>(context).itemListInCart.length;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 5,
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "ChatChef",
          style: TextStyle(color: Color.fromARGB(255, 129, 122, 122)),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 18, top: 5),
            child: Badge(
              label: Text(
                cartItemCount != 0 ? cartItemCount.toString() : '',
                style: const TextStyle(
                    color: Colors.indigo,
                    fontSize: 14,
                    fontWeight: FontWeight.w900),
              ),
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {
                    nextScreen(context, CartPage());
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.indigo,
                  )),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: _isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1466637574441-749b8f19452f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        "Nawab's Kitchen",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        'Popular Items',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemList.length,
                      physics: NeverScrollableScrollPhysics(),
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
                  ],
                ),
        ),
      ),
    );
  }
}
