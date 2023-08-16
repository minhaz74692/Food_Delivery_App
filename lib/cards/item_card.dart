// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_kitchen_quiz/models/menu_item.dart';
import 'package:remote_kitchen_quiz/providers/item_bloc.dart';
import 'package:remote_kitchen_quiz/utils/toast.dart';

class ItemCard1 extends StatelessWidget {
  const ItemCard1({super.key, required this.item, required this.thisItemList});
  final MenuItem item;
  final List<MenuItem> thisItemList;

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
                    SizedBox(
                      width: 80,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ItemModal(
                                  item: item,
                                  thisItemList: thisItemList,
                                );
                              });
                        },
                        child: Center(
                          child: Text(
                            'Add +',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
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
            ClipRRect(
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
          ],
        ),
      ),
    );
  }
}

class ItemModal extends StatefulWidget {
  const ItemModal({super.key, required this.item, required this.thisItemList});
  final MenuItem item;
  final List<MenuItem> thisItemList;

  @override
  State<ItemModal> createState() => _ItemModalState();
}

class _ItemModalState extends State<ItemModal> {
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    // itemCount = widget.thisItemList.length;
  }

  @override
  Widget build(BuildContext context) {
    final ib = context.watch<ItemBloc>();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                widget.item.image.toString(),
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Text(
                widget.item.name.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.item.description.toString(),
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (itemCount > 0) {
                        // ib.removeItemFromCart(widget.item);
                        setState(() {
                          itemCount--;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    itemCount.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // ib.addItemToCart(widget.item);
                      setState(() {
                        itemCount++;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
                onPressed: () {
                  showMessage('$itemCount Item Added to Your Cart');
                  Future.delayed(Duration(milliseconds: 200), () {
                    for (var i = 0; i < itemCount; i++) {
                      ib.addItemToCart(widget.item);
                    }
                    setState(() {
                      itemCount = 0;
                    });
                    Navigator.pop(context);
                  });
                },
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
