import 'package:sultan_delivary/Screens/data/Food.dart';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'util.dart';

class FoodAPI {
  Future fetchalldata() async {
    String allCatAPI = api_bse + foodapi;
    List<Food> foods = List<Food>();

    var response = await http.get(allCatAPI);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
      for (var data in jsonResponse) {
        Food cat = new Food(data['id'], data['image'], data['price'],
            data['disprice'], data['title'], data['subtitle'], data['detiles']);
        foods.add(cat);
      }
    }
    return foods;
  }

  Future fetchalldataById(int catId) async {
    String allCatAPI = api_bse + foodapi + "&category_id=" + catId.toString();
    List<Food> foods = List<Food>();

    var response = await http.get(allCatAPI);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
      for (var data in jsonResponse) {
        Food cat = new Food(data['id'], data['image'], data['price'],
            data['disprice'], data['title'], data['subtitle'], data['detiles']);
        foods.add(cat);
      }
    }
    return foods;
  }

  Future fetchimageById(int foodId) async {
    String allCatAPI = api_bse + foodapi + "&category_id=" + foodId.toString();
    List<Food> foods = List<Food>();

    var response = await http.get(allCatAPI);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
      for (var data in jsonResponse) {
        Food cat = new Food(data['id'], data['image'], data['price'],
            data['disprice'], data['title'], data['subtitle'], data['detiles']);
        foods.add(cat);
      }
    }
    return foods;
  }
}
