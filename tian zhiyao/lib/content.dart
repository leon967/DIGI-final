import 'package:digi/postmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
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
  Color _likeButtonColor_1 = Colors.grey;
  Color _likeButtonColor_2 = Colors.grey;
  Color _likeButtonColor_3 = Colors.grey;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content'),
        backgroundColor: Colors.green[400],
      ),
      body: new ListView(
        children: [
          ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            children: [
              Image.asset(
                'assets/images/env.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/river.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/tiger.jpg',
                fit: BoxFit.cover,
              ),
            ],
            // onPageChanged: (value) {
            //   print('Page changed: $value');
            // },
            autoPlayInterval: 5000,
          ),
          new Container(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 8.0),
            child: new Row(
              children: [
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: new Text(
                          'Planting Trees',
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      new Row(
                        children: [
                          new Container(
                            child: new Text(
                              'Score',
                              style: new TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                          new Container(
                            padding: const EdgeInsets.only(left: 70.0),
                            child: new Text(
                              '3.8',
                              style: new TextStyle(
                                color: Colors.green[500],
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                new IconButton(
                  icon: Icon(FontAwesomeIcons.solidHeart),
                  color: _likeButtonColor_1,
                  onPressed: () {
                    setState(() {
                      if (_likeButtonColor_1 == Colors.grey) {
                        _likeButtonColor_1 = Colors.red[300]!;
                      } else {
                        _likeButtonColor_1 = Colors.grey;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: new Text(
              '''We promote environmental protection and oppose the expansion of power plants, the abuse of pesticides, the occupation of rural land, attention to excessive consumption, urban air pollution, water pollution, reclamation and environmental management errors.

More than half the world’s GDP – 44 trillion – is highly or moderately dependent on nature. Global environmental change puts nearly 10 trillion of economic value at risk by 2050 and could result in large-scale price rises in major commodities such as timber and cotton. For example, deforestation of tropical rainforests risks creating unstable weather patterns that could drastically increase water scarcity in affected regions. Similarly, the destruction of coral reefs (e.g., via trawler fishing) displaces vital breeding grounds for the regeneration of global fish stocks.''',
              softWrap: true,
              textAlign: TextAlign.justify,
              style: new TextStyle(
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
          new Container(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
            child: new Text(
              'Comments',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ),
          new Container(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          FontAwesomeIcons.userAstronaut,
                          size: 35,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: 'Jack',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18.0,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                                text: "        08-20",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.grey[600]))
                                          ]),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    flex: 5,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 0.0),
                                      child: IconButton(
                                        icon: Icon(FontAwesomeIcons.solidHeart),
                                        color: _likeButtonColor_2,
                                        onPressed: () {
                                          setState(() {
                                            if (_likeButtonColor_2 ==
                                                Colors.grey) {
                                              _likeButtonColor_2 =
                                                  Colors.red[300]!;
                                            } else {
                                              _likeButtonColor_2 = Colors.grey;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                            new Container(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 8.0, 0.0),
                              child: new Text(
                                'Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!',
                                textAlign: TextAlign.justify,
                                style: new TextStyle(
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          FontAwesomeIcons.solidUser,
                          size: 35,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: 'Jen',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18.0,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                                text: "          08-21",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.grey[600]))
                                          ]),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    flex: 5,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 0.0),
                                      child: IconButton(
                                        icon: Icon(FontAwesomeIcons.solidHeart),
                                        color: _likeButtonColor_3,
                                        onPressed: () {
                                          setState(() {
                                            if (_likeButtonColor_3 ==
                                                Colors.grey) {
                                              _likeButtonColor_3 =
                                                  Colors.red[300]!;
                                            } else {
                                              _likeButtonColor_3 = Colors.grey;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                            new Container(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 8.0, 15.0),
                              child: new Text(
                                'Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!Sound interesting, good job!',
                                textAlign: TextAlign.justify,
                                style: new TextStyle(
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
