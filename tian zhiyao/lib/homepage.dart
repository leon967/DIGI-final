import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'postmodel.dart';
import 'postinfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
      appBar: new AppBar(
        backgroundColor: Colors.green[400],
        title: Text(
          "HomePage",
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          Icons.account_circle,
          color: Colors.white,
          size: 35.0,
        ),
      ),
      body: dataList.length == 0
          ? Center(child: Text("No data available"))
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (_, index) {
                return cardUI(
                  dataList[index].eventName,
                  dataList[index].description,
                  dataList[index].date,
                  dataList[index].imgPath,
                  dataList[index].location,
                );
              }),
    );
  }

  Widget cardUI(String eventName, String description, String date,
      String imgPath, String location) {
    return new InkWell(
      splashColor: Colors.green[300],
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => PostInfo()),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostInfo(),
              settings: RouteSettings(
                arguments: Args()
            )
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.file(
                File(imgPath),
                fit: BoxFit.cover,
                height: 230.0,
                width: MediaQuery.of(context).size.width - 40,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 15.0,
                    bottom: 10.0,
                  ),
                  child: Text(
                    eventName,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  // Flexible(fit: FlexFit.tight, child: SizedBox()),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    right: 15.0,
                    bottom: 10.0,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.date_range, color: Colors.green[600],),
                      Text(date, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  // Flexible(fit: FlexFit.tight, child: SizedBox()),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0, bottom: 5.0, right: 10.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
