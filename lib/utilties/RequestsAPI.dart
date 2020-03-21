import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sultan_delivary/Screens/data/Request.dart';
import 'util.dart';

class RequestAPI {
  Future<List<Request>> fetchalldata() async {
    String allCatAPI = api_bse + requestsapi;
    List<Request> requests = List<Request>();

    var response = await http.get(allCatAPI);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
      for (var data in jsonResponse) {
        Request _request = new Request(
            data['id'].toString(),
            data['customer_name'],
            data['customer_phone'],
            data['phoneid'],
            data['customer_address'],
            data['food'],
            data['food_title'],
            data['drinks'],
            data['quantity'],
            data['total_price']);
        requests.add(_request);
      }
    }
    return requests;
  }

  Future insertdata(Map<String, dynamic> map) async {
    List<Request> requests = List<Request>();

    var url = api_bse + "requests/";
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonEncode(map));
    if (response.statusCode == 201) {
      var data = convert.jsonDecode(utf8.decode(response.bodyBytes));
      Request _request = new Request(
          data['id'].toString(),
          data['customer_name'],
          data['customer_phone'],
          data['phoneid'],
          data['customer_address'],
          data['food'],
          data['food_title'],
          data['drinks'],
          data['quantity'],
          data['total_price']);
      requests.add(_request);
      phoneid = data['phoneid'];
    } else {
      throw response.statusCode;
    }
  }

  Future<String> fetchalldataByPhone(String phoneid) async {
    String allCatAPI =
        api_bse + 'requestz/?' + 'phoneid=$phoneid&food=&format=json';
    int number = 0;
    var response = await http.get(allCatAPI);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
      for (var data in jsonResponse) {
        if (data['phoneid'] == phoneid) {
          number++;
        }
      }
    }
    return number.toString();
  }

  Future<String> fetchalldataByprice(String phoneid) async {
    String allCatAPI =
        api_bse + 'requestz/?' + 'phoneid=$phoneid&food=&format=json';
    int number = 0;
    var response = await http.get(allCatAPI);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
      for (var data in jsonResponse) {
        if (data['phoneid'] == phoneid) {
          number += int.parse(data['total_price']);
        }
      }
    }
    return number.toString();
  }

  Future fetchalldataById(String phoneid) async {
    String allCatAPI =
        api_bse + 'requestz/?' + 'phoneid=$phoneid&food=&format=json';
    List<Request> requests = List<Request>();

    var response = await http.get(allCatAPI);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
      for (var data in jsonResponse) {
        if (data['phoneid'] == phoneid) {
          Request _request = new Request(
              data['id'].toString(),
              data['customer_name'],
              data['customer_phone'],
              data['phoneid'],
              data['customer_address'],
              data['food'],
              data['food_title'],
              data['drinks'],
              data['quantity'],
              data['total_price']);
          requests.add(_request);
        }
      }
    }
    return requests;
  }

  Future<String> deleteWithURl(String id) async {
    final baseUrl = api_bse;
    final url = Uri.parse(baseUrl + "requests/$id/");
    var response = await http.delete(url,
        headers: {"Content-Type": "application/json"});
    if (response.statusCode != 200)
      return Future.error("error: status code ${response.statusCode}");
  }

}
