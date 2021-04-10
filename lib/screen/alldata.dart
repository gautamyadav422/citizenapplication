import 'package:citizenapplication/screen/create_reports.dart';
import 'package:citizenapplication/screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllData extends StatefulWidget {
  @override
  _AllDataState createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  CollectionReference users = FirebaseFirestore.instance.collection('test1');
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
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Create Reports"),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => CreateReports()));
          },
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Someting wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        trailing: Text("Pending"),
                        title: Text(document.data()['title']),
                        subtitle: Text(document.data()['Description']),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ));
  }
}
