// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_kitchen_quiz/models/menu_item.dart';
import 'package:remote_kitchen_quiz/providers/item_bloc.dart';
import 'package:remote_kitchen_quiz/utils/next_screen.dart';

class ItemCard1 extends StatelessWidget {
  const ItemCard1(
      {super.key, required this.item, required this.thisProductList});
  final MenuItem item;
  final List<MenuItem> thisProductList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      item.description!.length > 28
                          ? '${item.description!.substring(0, 28)}...'
                          : '${item.description}...',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'CA\$${item.basePrice.toString()} ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SizedBox(
                        height: 35,
                        width: 150,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 7, 255, 27),
                          ),
                          onPressed: () {
                            Provider.of<ItemBloc>(context, listen: false)
                                .addProductToCart(item);
                          },
                          child: Text(
                            'Add To Cart',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Container(
              // height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Image.network(
                  item.image.toString(),
                  width: 100,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
