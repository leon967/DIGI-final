import 'dart:io';
import 'package:digi/postmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'homepage.dart';

class PostInfo extends StatefulWidget {
  @override
  _PostInfo createState() => _PostInfo();
}

class _PostInfo extends State<PostInfo> {
  List<PostModel> dataList = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference referenceData =
    FirebaseDatabase.instance.reference().child('User');
    referenceData.once().then((DataSnapshot dataSnapShot) {
      dataList.clear();
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        PostModel data = new PostModel(
          values[key]["EventName"],
          values[key]["Description"],
          values[key]["Date"],
          values[key]["ImagePath"],
          values[key]["location"],
          values[key]["Link"],
          values[key]["Latitude"],
          values[key]["Longitude"],
        );
        dataList.add(data);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: dataList.length == 0
          ? Center(child: Text("No data available"))
          : ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (_, index) {
            return postUI(
              dataList[index].eventName,
              dataList[index].description,
              dataList[index].date,
              dataList[index].imgPath,
              dataList[index].location,
              dataList[index].link,
            );
          }),
    );
  }

  Widget postUI(String eventName, String description, String date,
      String imgPath, String location, String bookingLink) {
    return new Container(
      child: Column(
        children: [
          Image.file(File(imgPath)),
          SizedBox(height: 12.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: Colors.grey,
                size: 13.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Icon(
                Icons.circle,
                color: Colors.grey,
                size: 13.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Icon(
                Icons.circle,
                color: Colors.green[600],
                size: 13.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              eventName,
              style: TextStyle(
                fontFamily: 'FredokaOne',
                fontSize: 25.0,
              ),
            ),
          ),
          SizedBox(height: 8.0,),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              description,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(height: 8.0,),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Bookings",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontFamily: 'FredokaOne',
              ),
            ),
          ),
          SizedBox(height: 8.0,),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Text(
                  "Bookings required via ",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "Eventbrite",
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}