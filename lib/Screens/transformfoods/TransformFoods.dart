import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sultan_delivary/Screens/FoodsRequest/FoodRequest.dart';
import 'package:sultan_delivary/utilties/TextStyles.dart';
import 'package:sultan_delivary/utilties/RequestsAPI.dart';
import 'package:sultan_delivary/utilties/util.dart';

class TransformFoods extends StatefulWidget {
  final int counter;
  final int foodId;

  final String price;

  final List drinks;

  TransformFoods(this.foodId, this.counter, this.drinks, this.price);

  @override
  _TransformFoodsState createState() =>
      _TransformFoodsState(foodId, counter, drinks, price);
}

class _TransformFoodsState extends State<TransformFoods> {
  HashMap<String, dynamic> requestsMap = new HashMap();

  @override
  bool checkboxvalue = false;
  String checkboxText = '';

  final int counter;
  final int foodId;
  final List drinks;
  final String price;

  RequestAPI _requestAPI = new RequestAPI();

  final customer_name = TextEditingController();
  final customer_phone = TextEditingController();
  final customer_address = TextEditingController();

  _TransformFoodsState(this.foodId, this.counter, this.drinks, this.price);

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.amber, //change your color here
            ),
            title: Text(
              'گەیاندن',
              style: titleStyle,
            ),
            centerTitle: false,
          ),
          body: DetailesTrasnformFoodsa(),
          bottomNavigationBar: _FooterButton(),
        ),
      ),
    );
  }

  Widget _FooterButton() {
    return BottomAppBar(
      color: Colors.grey.shade900,
      child: Container(
        color: Colors.black12,
        padding: EdgeInsets.only(left: 120, right: 120, bottom: 6),
        child: RaisedButton(
          color: Colors.green.shade900,
          child: Wrap(
            direction: Axis.horizontal,
            children: <Widget>[
              Text(' داواکردن', style: testButtonStulefoodRequest),
              Icon(
                Icons.send,
                color: Colors.white,
              ),
            ],
            //
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          onPressed: () {
            requestsMap['customer_name'] = customer_name.text;
            requestsMap['customer_phone'] = customer_phone.text;
            requestsMap['customer_address'] = customer_address.text;
            requestsMap['quantity'] = counter.toString();
            requestsMap['food'] = foodId;
            requestsMap['total_price'] = price.toString();
            requestsMap['drinks'] = drinks;
            requestsMap['phoneid'] = phoneid;
            _requestAPI.insertdata(requestsMap);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodRequest()),
            );
          },
        ),
      ),
    );
  }

  DetailesTrasnformFoodsa() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: Wrap(
          // crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/logodiv.jpg'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
              width: 150,
              height: 150,
              margin: EdgeInsets.only(right: 125, bottom: 25),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _detailesLabelPersonRequest(),
                _detailesTextFeildPersonRequest(),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 100,
              child: Row(
                children: <Widget>[
                  Checkbox(
                    onChanged: (bool e) => something(),
                    value: checkboxvalue,
                  ),
                  Container(
                    child: Text(
                      "دیاری کردنی ناونیشانی ئێستا",
                      style: TextStyle(color: Colors.amber, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailesLabelPersonRequest() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 50,
            child: Text("ناو : ", style: detailesPersonRequest),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 70,
            child: Text("ژ.مۆبایل : ", style: detailesPersonRequest),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            child: Text("ناونیشان : ", style: detailesPersonRequest),
          ),
        ],
      ),
    );
  }

  Widget _detailesTextFeildPersonRequest() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 250,
            height: 40,
            child: TextFormField(
              controller: customer_name,
              style: new TextStyle(
                color: Colors.amber,
                fontSize: 16,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                enabledBorder: _UnderlineInputBorder(),
                focusedBorder: _focusedBorderUnderlineInputBorder(),
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'ناوی داواکار',
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 250,
            height: 40,
            child: TextFormField(
              controller: customer_phone,
              style: new TextStyle(
                color: Colors.amber,
                fontSize: 16,
              ),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                enabledBorder: _UnderlineInputBorder(),
                focusedBorder: _focusedBorderUnderlineInputBorder(),
                hintStyle: TextStyle(color: Colors.grey),
                hintText: '*********07',
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 250,
            height: 40,
            child: TextFormField(
              controller: customer_address,
              style: new TextStyle(
                color: Colors.amber,
                fontSize: 16,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                enabledBorder: _UnderlineInputBorder(),
                focusedBorder: _focusedBorderUnderlineInputBorder(),
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'ناونیشانی داواکار',
              ),
            ),
          ),
        ],
      ),
    );
  }

  UnderlineInputBorder _UnderlineInputBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.amber),
    );
  }

  UnderlineInputBorder _focusedBorderUnderlineInputBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.green),
    );
  }

  void something() {
    setState(() {
      if (checkboxvalue) {
        checkboxText = "ناونیشانەکەت بەسەرکەوتویی دیاری کرا !";
        //  alarmLocation(checkboxText );
        checkboxvalue = !checkboxvalue;
      } else {
        checkboxText = "تکایە چاوەڕوانبە ، ئێستا ناونیشانەکەت دیاری دەکرێت";
        //  alarmLocation(checkboxText );
        checkboxvalue = !checkboxvalue;
      }
    });
  }

  alarmLocation(String text) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
