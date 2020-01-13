import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  String locality;
  String city;
  String state;
  File _image;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Position position =
        await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('Postion ==> $position');
    print('Latitude ==> ${position.latitude}');
    print('Langitude ==> ${position.longitude}');
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    print('Locality ==> ${placemark[0].locality}');
    print('AdministrativeArea ==> ${placemark[0].administrativeArea}');
    print('SubAdministrativeArea ==> ${placemark[0].subAdministrativeArea}');
    print('SubLocality ==> ${placemark[0].subLocality}');

    if (placemark[0].subLocality.isNotEmpty) {
      locality = placemark[0].subLocality;
    }
    if (placemark[0].subAdministrativeArea.isNotEmpty) {
      city = placemark[0].subAdministrativeArea;
    }
    if (placemark[0].administrativeArea.isNotEmpty) {
      state = placemark[0].administrativeArea;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              location(),
              doctorDetails(),
              healthAdvisorLabel(),
              healthAdvisorList(),
              exploreInsuranceLabel(),
              exploreInsuranceList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget location() {
    return Card(
      elevation: 15,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text(locality + " " + city + " " + state),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.edit),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Icon(Icons.call),
                    ),
                    Icon(Icons.line_weight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget doctorDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1, color: Colors.black12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: CircleAvatar(
                  child: _image == null
                      ? Text(
                          "Take a photo",
                          textAlign: TextAlign.center,
                        )
                      : ClipOval(
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                  minRadius: 50,
                  maxRadius: 50,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Jennifier Wilson',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 25,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Mumbai, India',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              size: 25,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '12-Apr-1994',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget healthAdvisorLabel() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Health Advisor',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget healthAdvisorList() {
    return Container(
      height: 150.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int i) {
            return Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Container(
                height: 100,
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Card(
                  elevation: 2.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("From treatment guidence\n to post hospitalization care,"),
                              FlatButton(
                                onPressed: () {},
                                child: Text('Get in touch'),
                                color: Colors.blue,
                                textColor: Colors.white,
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(child: Icon(Icons.local_hospital))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget exploreInsuranceLabel() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Explore our Insurance Products',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget exploreInsuranceList() {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, int i) {
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black12, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 5, color: Colors.black12),
                      image: new DecorationImage(
                        fit: BoxFit.none,
                        image: NetworkImage(
                            "http://www.rcity.co.in/wp-content/uploads/2016/10/IMG_0907.jpg"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Health Insurance redifined!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Sodawala Ln,Borivali West',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Last Ordered(3 Days ago)',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
}
