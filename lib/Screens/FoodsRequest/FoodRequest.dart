import 'package:flutter/material.dart';
import 'package:sultan_delivary/Screens/data/Request.dart';
import 'package:sultan_delivary/utilties/TextStyles.dart';
import 'package:sultan_delivary/shared_ui/Navigation_drawer.dart';
import 'package:sultan_delivary/Screens/FoodsRequest/EditeFoodRequest.dart';
import 'package:sultan_delivary/utilties/RequestsAPI.dart';
import 'package:sultan_delivary/utilties/util.dart';

class FoodRequest extends StatefulWidget {
  @override
  _FoodRequestState createState() => _FoodRequestState();
}

class _FoodRequestState extends State<FoodRequest> {
  RequestAPI _requestAPI = new RequestAPI();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: BackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.pink.shade600,
            title: Text(
              'لیستی داواکراوەکان',
              style: titleStyleFoodRequest,
            ),
            centerTitle: false,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: IconsColorFoodRequest,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditeFoodRequest()),
                    );
                  }),
            ],
          ),
          drawer: NavegationDrawer(),
          body: Container(
            child: SingleChildScrollView(
              child: Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  FutureBuilder(
                      future: _requestAPI.fetchalldataById(phoneid),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                Request reuqest = snapshot.data[index];
                                return _DetailesOFFoodRequest(reuqest.food_title, reuqest.quantity, reuqest.price);
                              });
                        } else if (snapshot.hasError) {
                          throw snapshot.error;
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  _SumallpriceWidget(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade900,
            child: Wrap(
              children: <Widget>[
                Container(
                  color: Colors.black12,
                  padding: EdgeInsets.only(left: 125, right: 125, bottom: 6),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.pink.shade600,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(' پەسەندکردن',
                                style: testButtonStulefoodRequest),
                            Icon(
                              Icons.done_all,
                              color: Colors.white,
                            ),
                          ],
                          //
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => TransformFoods()),
//                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _DetailesOFFoodRequest(
      String nameoffood, String countoffoodNum, String priceoffood) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                nameoffood,
                style: NameOFFoodRequest,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'x$countoffoodNum',
                style: StylecountoffoodRequest,
              ),
              Text(
                '$priceoffoodدینار ',
                style: StylepriceoffoodRequest,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _SumallpriceWidget() {
    return Column(
      children: <Widget>[
        _drawDivider(),
        Container(
          padding: EdgeInsets.only(right: 20, top: 10),
          child: Row(
            children: <Widget>[
              Container(
                  child: Text(
                'کۆی گشتی  :',
                style: TextStyle(color: Colors.amber, fontSize: 22),
              )),
              Transform.translate(
                offset: Offset(-150, 0),
                child: Container(
                    child: getData()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getData() {
    if (phoneid != '') {
      return FutureBuilder(
          future: _requestAPI.fetchalldataByprice(phoneid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data,style: TextStyle(color: Colors.white, fontSize: 14),);
            } else if (snapshot.hasError) {
              return Text("0",style: TextStyle(color: Colors.white, fontSize: 14),);
            }
            return Text('',style: TextStyle(color: Colors.white, fontSize: 14),);
          });
    }else{
      return Text("0",style: TextStyle(color: Colors.white, fontSize: 14),);
    }
  }

  Widget _drawDivider() {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: Colors.grey.shade500,
    );
  }
}
