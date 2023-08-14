// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:remote_kitchen_quiz/models/menu_item.dart';

// ...

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic jData;
  Future<void> fetchJsonData() async {
    // final response = await http.get(Uri.parse(
    //     'https://api.chatchefs.com/api/food/v1/menu/?format=json&locations=2'));

    // if (response.statusCode == 200) {
    //   final jsonData = json.decode(response.body);
    //   List<dynamic> menuItemsData = jsonData['results'][0]['menuitem_set'];
    //   List<MenuItem> menuItems =
    //       menuItemsData.map((itemJson) => MenuItem.fromJson(itemJson)).toList();
    //   print(menuItems.length);
    // } else {
    //   print('Request failed with status: ${response.statusCode}');
    // }
    final response = await http.get(Uri.parse(
        'https://api.chatchefs.com/api/food/v1/menu/?format=json&locations=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = await json.decode(response.body);
      List<dynamic> menuItemsData =
          await jsonData['results'][0]['menuitem_set'];

      List<MenuItem> menuItems =
          menuItemsData.map((itemJson) => MenuItem.fromJson(itemJson)).toList();
      print(menuItems[0].basePrice.runtimeType);
    } else {
      throw Exception('Failed to load menu items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () => fetchJsonData(), child: const Text('Click'))),
      ),
    );
  }
}
