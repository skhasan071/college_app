import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class Statecity extends StatefulWidget{
  String state;

  String city;

  Statecity({required this.state,required this.city});
  @override
  State<Statecity> createState() => _StatecityState();
}

class _StatecityState extends State<Statecity> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("state: ${widget.state}",style:TextStyle(fontSize: 20),),
            Text("city : ${widget.city}",style:TextStyle(fontSize: 20)),

          ],
        ),
      )
    );



  }

}