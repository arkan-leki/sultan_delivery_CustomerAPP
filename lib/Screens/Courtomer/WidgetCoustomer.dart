import 'package:flutter/material.dart';
import 'package:sultan_delivary/Screens/data/TransformFood.dart';
import 'package:sultan_delivary/utilties/TextStyles.dart';
import 'package:sultan_delivary/shared_ui/Navigation_drawer.dart';
import 'package:sultan_delivary/Screens/Courtomer/ListOfCoustomerRequest.dart';
import 'package:sultan_delivary/utilties/TransformAPI.dart';
import 'package:sultan_delivary/utilties/util.dart';

class WidgetCoustomer extends StatefulWidget {
  @override
  _WidgetCoustomerState createState() => _WidgetCoustomerState();
}

class _WidgetCoustomerState extends State<WidgetCoustomer> {
  TransformAPI _transformAPI = new TransformAPI();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: BackgroundColor,
          appBar: AppBar(
            backgroundColor: AppbarColor,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              'لیستی گواستنەوە',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            centerTitle: false,
          ),
          drawer: NavegationDrawer(),
          body: FutureBuilder(
              future: _transformAPI.fetchalldata(phoneid),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      TransformFood transform = snapshot.data[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListOfCoustomerRequest(transform),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  throw snapshot.error;
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
