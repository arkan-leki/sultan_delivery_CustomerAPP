import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sultan_delivary/Screens/FoodsRequest/FoodRequest.dart';
import 'package:sultan_delivary/Screens/data/Food.dart';
import 'package:sultan_delivary/utilties/TextStyles.dart';
import 'package:sultan_delivary/shared_ui/Navigation_drawer.dart';
import 'package:sultan_delivary/Screens/FoodsRequest/DetilesFoodsRequest.dart';

class DiscountFoods extends StatefulWidget {
  @override
  _DiscountFoodsState createState() => _DiscountFoodsState();
}

class _DiscountFoodsState extends State<DiscountFoods> {
  @override
  List<int> ids = [0, 2, 7];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: BackgroundColor,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.amber,
            title: Text(
              'داشکاندنەکان',
              style: titleStyleOtherWidegt,
            ),
            centerTitle: false,
          ),
          drawer: NavegationDrawer(),
          body: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, position) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              color: Colors.grey.shade800,
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      _Food(new Food(
                                          1,
                                          'assets/images/burgger.jpg',
                                          '10000',
                                          '5000',
                                          'pizza',
                                          'subtitle',
                                          "detail")),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  _drawFooter(position),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodRequest()),
              );
            },
            backgroundColor: Colors.pink.shade600,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                ),
                Text('0'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _Food(Food food) {
    return Column(
      children: <Widget>[
        _drawimage(food.image, food.price, food.disprice),
        _drawTitle(food.title, food.subtitle, food.detiles),
      ],
    );
  }

  Widget _drawFooter(int position) {
    return Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                if (ids.contains(position)) {
                  ids.remove(position);
                } else {
                  ids.add(position);
                }
                setState(() {});
                print(ids);
              },
              color:
                  (ids.contains(position)) ? Colors.red : Colors.grey.shade400,
            ),
          ],
        ),
        Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 50),
              child: RaisedButton(
                color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    ),
                    Text(' داواکردن', style: testButtonStuleNewFood),
                  ],
                  //
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetilesFoodsRequest(position)),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _drawTitle(String title, String subtitle, String detiles) {
    return Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 10),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: titleStyleNewFood,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  subtitle,
                  style: subtitleStyleNewFood,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  detiles,
                  style: detilesStyleNewFood,
                ),
              ],
            ),
          ],
        ));
  }

  Widget _drawimage(String image, String price, String disprice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
        ),
        _PriceFoods(int.parse(price), int.parse(disprice)),
      ],
    );
  }

  _PriceFoods(int price, int disPrice) {
    return Wrap(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 4, right: 6),
              height: 40,
              child: Text("نرخ: $price دینار", style: OldPriceFoods),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
                color: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 4, right: 6),
              height: 40,
              child: Text("ئێستا: $disPrice دینار", style: disPriceFoods),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
