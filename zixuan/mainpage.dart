import 'package:digi/content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'posthelper.dart';
import 'postmol.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color _likeButtonColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.account_circle,
          color: Colors.black,
          size: 35.0,
        ),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, position) {
          PostMol post = PostHelper.getTweet(position);

          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: post.username,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                          text: " " + post.handle,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.green[700])),
                                      TextSpan(
                                          text: "    ${post.time}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.blue[600]))
                                    ]),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  flex: 5,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Icon(
                                      Icons.expand_more,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Content()));
                            },
                            child: Text(
                              post.article,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.fromLTRB(.0, 4.0, 8.0, 4.0),
                          //   child: Text(
                          //     post.article,
                          //     style: TextStyle(fontSize: 18.0),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image(
                              image: AssetImage('assets/images/env.jpg'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.comment,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  FontAwesomeIcons.exchangeAlt,
                                  color: Colors.grey,
                                ),
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.grinHearts),
                                  color: _likeButtonColor,
                                  onPressed: () {
                                    setState(() {
                                      if (_likeButtonColor == Colors.grey) {
                                        _likeButtonColor = Colors.red[300]!;
                                      } else {
                                        _likeButtonColor = Colors.grey;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
