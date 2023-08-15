import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:remote_kitchen_quiz/models/menu_item.dart';

class ApiHelper {
  static ApiHelper instance = ApiHelper();
  Future<List<MenuItem>> getMenuItems() async {
    final response = await http.get(Uri.parse(
        'https://api.chatchefs.com/api/food/v1/menu/?format=json&locations=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = await json.decode(response.body);
      List<dynamic> menuItemsData =
          await jsonData['results'][0]['menuitem_set'];

      List<MenuItem> menuItems =
          menuItemsData.map((itemJson) => MenuItem.fromJson(itemJson)).toList();
      print(menuItems[0].basePrice.runtimeType);
      return menuItems;
    } else {
      print('Error to fetch item.');
      return [];
    }
  }
}
