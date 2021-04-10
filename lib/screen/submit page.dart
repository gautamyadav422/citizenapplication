import 'package:flutter/material.dart';
import 'alldata.dart';
import 'login.dart';

class Submit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Reports Details",
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => LoginPage()));
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:150.0),
        child: Center(
          child: Column(
            children: [
              Text("Your Form is Submitted",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
              Text("Successfully",style: TextStyle(color: Colors.green,fontSize: 35),),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text(
                    'View Submit Details',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (ctx) => AllData()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
