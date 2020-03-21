import 'package:sultan_delivary/Screens/data/Drink.dart';
import 'package:sultan_delivary/Screens/data/Food.dart';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'util.dart';

class DrinkAPI {
  Future fetchalldata(int foodId) async {
    String allCatAPI = api_bse + drinkapi + "&food=" + foodId.toString();
    List<Drink> drinks = List<Drink>();

    var response = await http.get(allCatAPI);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
      for (var data in jsonResponse) {
        Drink drink =
            new Drink(data['id'], data['food'], data['title'], data['price']);
        drinks.add(drink);
      }
    }
    return drinks;
  }
}
