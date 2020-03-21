import 'package:flutter/material.dart';
import 'package:sultan_delivary/Screens/FoodsRequest/DetilesFoodsRequest.dart';
import 'package:sultan_delivary/Screens/data/Request.dart';
import 'package:sultan_delivary/utilties/TextStyles.dart';
import 'package:sultan_delivary/utilties/RequestsAPI.dart';
import 'package:sultan_delivary/utilties/util.dart';

class EditeFoodRequest extends StatefulWidget {
  @override
  _EditeFoodRequestState createState() => _EditeFoodRequestState();
}

class _EditeFoodRequestState extends State<EditeFoodRequest> {
  RequestAPI _requestAPI = new RequestAPI();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink.shade600,
            title: Text(
              'گۆڕانکاری لیستی داواکراوەکان',
              style: titleStyleFoodRequest,
            ),
            centerTitle: false,
          ),
          body: Container(
              color: BackgroundColor,
              child:
                  FutureBuilder(
                      future: _requestAPI.fetchalldataById(phoneid),
                      builder: (context, AsyncSnapshot snapshot){
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              Request request = snapshot.data[index];
                              return Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                    ),
                                    child: _DetailesOFFoodRequest(request.food_title, request.quantity, request.price,request.id),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          throw snapshot.error;
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                  )
      ),
        ),
      ),
    );
  }

  Widget _DetailesOFFoodRequest(
      String nameoffood, String countoffoodNum, String priceoffood, String foodId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              color: Colors.green.shade600,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetilesFoodsRequest(int.parse(foodId))),
                );
              },
            ),
            Text(
              nameoffood,
              style: NameOFFoodRequest,
            )
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              '($priceoffoodدینار) ',
              style: StylepriceoffoodRequest,
            ),
            IconButton(
              icon: Icon(
                Icons.restore_from_trash,
              ),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  _requestAPI.deleteWithURl(foodId);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
