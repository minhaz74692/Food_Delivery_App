// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:remote_kitchen_quiz/pages/home.dart';
import 'package:remote_kitchen_quiz/utils/next_screen.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage(
      {super.key,
      required this.totalPrice,
      required this.name,
      required this.mobile,
      required this.address});
  final double totalPrice;
  final String name;
  final String mobile;
  final String address;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 5,
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "Checkout Page",
          style: TextStyle(color: Color.fromARGB(255, 129, 122, 122)),
        ),
        leading: BackButton(
          color: Colors.grey[700],
          onPressed: () {
            nextScreen(context, HomePage());
           
          },
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 1,
                    width: 50,
                    color: Colors.blue, // Color of the line
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 50,
                    height: 1,
                    color: Colors.grey, // Color of the line
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 50,
                    height: 1,
                    color: Colors.grey, // Color of the line
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Order Id',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'kr293l12-32huksd8746834-234lk32',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Tracking URL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextButton(
                onPressed: () => nextScreen(context, HomePage()),
                child: Text(
                  'Track Your Order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Order Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Pending',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Estimated Delivery Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '18/08/2023',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Subtotal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${widget.totalPrice}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Delivery Fee',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '9.80',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
