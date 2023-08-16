// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_kitchen_quiz/models/menu_item.dart';
import 'package:remote_kitchen_quiz/pages/checkout_page.dart';
import 'package:remote_kitchen_quiz/providers/item_bloc.dart';
import 'package:remote_kitchen_quiz/providers/tabcontroller_bloc.dart';
import 'package:remote_kitchen_quiz/utils/next_screen.dart';
import 'package:remote_kitchen_quiz/utils/toast.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var nameCtlr = TextEditingController();
  var mobileCtlr = TextEditingController();
  var addressCtlr = TextEditingController();
  bool _validation = false;
  @override
  void initState() {
    super.initState();
  }

  void validation() {
    setState(() {
      if (nameCtlr.text.isEmpty ||
          mobileCtlr.text.length < 11 ||
          addressCtlr.text.isEmpty) {
        _validation = false;
      } else {
        _validation = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var currentIndex = Provider.of<TabControllerBloc>(context).currentIndex;
    final pb = context.watch<ItemBloc>();
    List<MenuItem> itemListInCart = pb.itemListInCart;
    List<MenuItem> sortedItemList = itemListInCart.toSet().toList();
    double totalPrice = 0;
    for (MenuItem product in itemListInCart) {
      totalPrice += product.basePrice!;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      appBar: AppBar(
        scrolledUnderElevation: 5,
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "Your Cart",
          style: TextStyle(color: Color.fromARGB(255, 129, 122, 122)),
        ),
        leading: BackButton(
          color: Colors.grey[700],
          onPressed: () {
            setState(() {
              currentIndex = 0;
            });
            Navigator.pop(context);
          },
        ),
      ),
      body: itemListInCart.isEmpty
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_cart.png',
                    width: 200,
                  ),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    child: Text(
                      'Add Item',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Cart Items',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: sortedItemList.length,
                      itemBuilder: (ctx, index) {
                        MenuItem singleProduct = sortedItemList[index];
                        List<MenuItem> thisProductList = itemListInCart
                            .where((product) => product.id == singleProduct.id)
                            .toList();

                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                spreadRadius: 1,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            // border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: Wrap(children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: 50,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                          singleProduct.image.toString())),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 160,
                                  child: Text(singleProduct.name.toString()),
                                ),
                                GestureDetector(
                                  child: Icon(Icons.remove),
                                  onTap: () {
                                    if (thisProductList.isNotEmpty) {
                                      pb.removeItemFromCart(singleProduct);
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  thisProductList.length.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  child: Icon(Icons.add),
                                  onTap: () {
                                    if (thisProductList.isNotEmpty) {
                                      pb.addItemToCart(singleProduct);
                                    }
                                  },
                                ),
                                Spacer(),
                                GestureDetector(
                                  child: Icon(CupertinoIcons.delete),
                                  onTap: () {
                                    showMessage(
                                        '${thisProductList.length} Item Removed from Cart');
                                    if (thisProductList.isNotEmpty) {
                                      pb.removeThisItemFromCart(singleProduct);
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ]),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Add Details',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      child: Container(
                        color: Colors.white,
                        child: TextFormField(
                          controller: nameCtlr,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: 'Enter Name',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                nameCtlr.clear();
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Value is empty';
                            }
                            return null; // Return null to indicate valid input
                          },
                          onChanged: (value) {
                            validation();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      child: Container(
                        color: Colors.white,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: mobileCtlr,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: '+880-XXXXXXXXXX',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                mobileCtlr.clear();
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Value is empty';
                            }
                            return null; // Return null to indicate valid input
                          },
                          onChanged: (value) {
                            validation();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      child: Container(
                        color: Colors.white,
                        child: TextFormField(
                          controller: addressCtlr,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: 'Enter Delivery Address',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                addressCtlr.clear();
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Value is empty';
                            }
                            return null; // Return null to indicate valid input
                          },
                          onChanged: (value) {
                            validation();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Subtotal: CA\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    _validation
                        ? Padding(
                            padding:
                                const EdgeInsets.only(bottom: 16, left: 16),
                            child: Text(
                              'Delivery Fee: CA\$ 9.80',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _validation ? Colors.blue : Colors.grey),
                        onPressed: () {
                          _validation ? showMessage('Order Confirmed') : null;
                          _validation
                              ? {
                                  nextScreen(
                                      context,
                                      CheckOutPage(
                                        totalPrice: totalPrice,
                                        name: nameCtlr.text,
                                        mobile: mobileCtlr.text,
                                        address: addressCtlr.text,
                                      ))
                                }
                              : nameCtlr.text.isEmpty
                                  ? showMessage('Name is required')
                                  : mobileCtlr.text.length < 11
                                      ? showMessage('Number is invalid')
                                      : addressCtlr.text.isEmpty
                                          ? showMessage('Address is required')
                                          : null;
                          
                        },
                        child: SizedBox(
                          width: 100,
                          height: 40,
                          child: Center(
                            child: Text('Checkout',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
