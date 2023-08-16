// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_kitchen_quiz/pages/cart_page.dart';
import 'package:remote_kitchen_quiz/providers/tabcontroller_bloc.dart';
import 'package:remote_kitchen_quiz/tabs/home_tab.dart';
import 'package:remote_kitchen_quiz/utils/next_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  static String title = 'salomon_bottom_bar';

  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var currentIndex = Provider.of<TabControllerBloc>(context).currentIndex;
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
          if (currentIndex == 2) {
            nextScreen(context, CartPage());
          } else {
            context.read<TabControllerBloc>().controlTab(i);
          }
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
            unselectedColor: Colors.grey[600],
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.search,
            ),
            title: Text("Search"),
            selectedColor: Colors.purple,
            unselectedColor: Colors.grey[600],
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            title: Text("Cart"),
            selectedColor: Colors.purple,
            unselectedColor: Colors.grey[600],
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: Text("Settings"),
            selectedColor: Colors.purple,
            unselectedColor: Colors.grey[600],
          ),
        ],
      ),
      body: PageView(
        allowImplicitScrolling: true,
        controller: context.read<TabControllerBloc>().pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeTab(),
          HomeTab(),
          CartPage(),
          HomeTab(),
        ],
      ),
    );
  }
}
