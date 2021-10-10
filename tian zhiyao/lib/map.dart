import 'package:digi/postmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'dart:math' show cos, sqrt, asin;

class Map extends StatefulWidget {
  @override
  _Map createState() => _Map();
}

class _Map extends State<Map> {
  final database = FirebaseDatabase.instance.reference();
  List<PostModel> dataList = [];
  List<String> latList = [];
  List<String> longList = [];
  List<double> distanceList = [];
  List<String> eventNameList = [];

  final LatLng _center = const LatLng(-27.470125, 153.021072);
  late GoogleMapController mapController;

  late double currentLatitude;
  late double currentLongitude;
  var currentPosition = '';

  List<Marker> allMarkers = [];

  // function that get user's current location
  // first to add permission to android/app/src/main/res/AndroidManifest.xml
  void getCurrentLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLongitude = position.longitude;
      currentLatitude = position.latitude;
    });
  }

  // function to create all the markers and store them into a list
  // latitude and longitude data both from realtime database, stored in list<String>
  List<Marker> createMarkers() {
    for (int i = 0; i < latList.length; i++) {
      double lati = double.parse(latList[i]);
      double longi = double.parse(longList[i]);
      Marker resultMarker = Marker(
        markerId: MarkerId("Marker$i"),
        draggable: false,
        position: LatLng(lati, longi),
      );
      setState(() {
        allMarkers.add(resultMarker);
      });
    }
    return allMarkers;
  }

  // function that calculate the distance of current location to each location on map
  // solution from https://medium.com/flutter-community/flutter-creating-a-route-calculator-using-google-maps-71699dd96fb9
  List<double> calculateDistance() {
    double p = 0.017453292519943295;
    var c = cos;
    double lat1 = currentLatitude;
    double lon1 = currentLongitude;

    for (int i = 0; i < latList.length; i++) {
      double lat2 = double.parse(latList[i]);
      double lon2 = double.parse(longList[i]);
      double a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      double distance = 12742 * asin(sqrt(a));

      setState(() {
        distanceList.add(distance);
      });
    }
    return distanceList;
  }

  // function that search the nearest location
  // return the marker instance of that location
  void nearestLocation(List<double> allDistance) {
    var indexMin;

    if (allDistance.length == 1) {
      // return allMarkers[0];
    } else {
      indexMin = allDistance.indexOf(allDistance.reduce(min));
      // return allMarkers[indexMin];
      setState(() {
        // createMarkers().removeAt(indexMin);
        createMarkers().add(new Marker(
          markerId: MarkerId((allMarkers.length + 1).toString()),
          draggable: false,
          position: allMarkers[indexMin].position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ));
      });
    }
  }

  Marker nearestMarker(List<double> allDistance) {
    var indexMin;

    if (allDistance.length == 1) {
      return allMarkers[0];
    } else {
      indexMin = allDistance.indexOf(allDistance.reduce(min));
      return allMarkers[indexMin];
    }
  }

  // function that return the nearest event name
  // return String value (name of that event)
  String nearestEvent(List<double> allDistance) {
    var indexMin;

    if (allDistance.length == 1) {
      return eventNameList[0];
    } else {
      indexMin = allDistance.indexOf(allDistance.reduce(min));
      return eventNameList[indexMin];
    }
  }

  @override
  void initState() {
    super.initState();

    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child('User');
    referenceData.once().then((DataSnapshot dataSnapShot) {
      dataList.clear();
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      // get all data from realtime database
      // store all the postModel instance into a empty list
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
        latList.add(values[key]["Latitude"]);
        longList.add(values[key]["Longitude"]);
        eventNameList.add(values[key]["EventName"]);
        dataList.add(data);
      }
    });
    getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          title: Text(
            "Map",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 35.0,
          ),
        ),
        body: dataList.length == 0
            ? Center(
                child: Text(
                "Loading google map...",
                style: TextStyle(
                  fontFamily: "FredokaOne",
                  fontSize: 20.0,
                ),
              ))
            : Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    markers: Set.from(createMarkers()),
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 12.0,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                  Positioned(
                    height: 50,
                    width: 120,
                    left: 5,
                    bottom: 60,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[400],
                      ),
                      onPressed: () {
                        // getCurrentLocation();
                        // print(calculateDistance());
                        // nearestLocation(calculateDistance());
                        nearestLocation(calculateDistance());
                      },
                      icon: Icon(
                        Icons.search,
                      ),
                      label: Text(
                        'Nearest Event',
                      ),
                    ),
                  ),
                  Positioned(
                    child: TextButton(
                      onPressed: () => _googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: nearestMarker(calculateDistance()).position,
                            zoom: 14.5,
                            tilt: 50.0,
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      child: const Text('DEST'),
                    ),
                  )
                ],
              ));
  }
}
