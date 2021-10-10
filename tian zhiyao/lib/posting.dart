import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Posting extends StatefulWidget {
  @override
  _Posting createState() => _Posting();
}

class _Posting extends State<Posting> {
  final database = FirebaseDatabase.instance.reference();
  final titleController = new TextEditingController();
  final articleController = new TextEditingController();
  final dateController = new TextEditingController();
  final timeController = new TextEditingController();
  final locationController = new TextEditingController();
  final linkController = new TextEditingController();
  File? image;

  // Function that pick images from system album
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to select images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = database.child('/User');
    var postID = 0;
    double maxWidth = MediaQuery.of(context).size.width;

    void addData(String title, String description, String date, String location,
        String time, String link, int postNo) {
      user.push().set({
        'EventName': title,
        'Date': date,
        'Location': location,
        'Latitude': '-27.3758366188676',
        'Longitude': '152.967160365427',
        'Link': link,
        'Description': description,
        'ImagePath': image!.path,
        'PostID': postNo,
      });
    }

    // Function that shows snack bar
    void showActionSnackBar(BuildContext context) {
      final snackBar = SnackBar(
        content: Text(
          'Post Successfully!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.green[600],
      );
      Scaffold.of(context)..showSnackBar(snackBar);
    }

    void postCounter() {
      postID = postID + 1;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        leading: Icon(
          Icons.account_circle,
          size: 35.0,
        ),
        title: Text(
          "Posting",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                onTap: () {
                  postCounter();
                  addData(
                      titleController.text,
                      articleController.text,
                      dateController.text,
                      locationController.text,
                      timeController.text,
                      linkController.text,
                      postID,
                  );
                  // print('successful');
                  showActionSnackBar(context);
                },
                child: Icon(
                  Icons.send,
                ),
              )),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 0.9 * maxWidth,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Event Name:',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontFamily: "FredokaOne",
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 0.9 * maxWidth,
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range),
                    hintText: 'Date:  e.g.  Sat 5 Sep 2021',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontFamily: "FredokaOne",
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 0.9 * maxWidth,
                child: TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    hintText: 'Time:  e.g.  14:00 - 18:00',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontFamily: "FredokaOne",
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 0.9 * maxWidth,
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.location_on_rounded),
                    hintText: 'Location: ',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontFamily: "FredokaOne",
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 0.9 * maxWidth,
                child: TextField(
                  controller: linkController,
                  decoration: InputDecoration(
                    hintText: 'Booking Link:',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontFamily: "FredokaOne",
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 0.9 * maxWidth,
                child: TextField(
                  controller: articleController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Description:",
                    labelStyle: TextStyle(
                      fontFamily: "FredokaOne",
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                    hintText: 'Type something...',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    image != null
                        ? Image.file(
                            image!,
                            width: 100,
                            height: 100,
                          )
                        : Container(
                            width: 100,
                            height: 100,
                          ),
                    GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Icon(
                        Icons.add_box_outlined,
                        size: 100,
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
