import 'dart:io';
import 'package:citizenapplication/screen/alldata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'submit page.dart';

class CreateReports extends StatefulWidget {
  final bool isUpdating;
  CreateReports({@required this.isUpdating});
  @override
  _CreateReportsState createState() => _CreateReportsState();
}

class _CreateReportsState extends State<CreateReports> {
  final TextEditingController title = TextEditingController();
  final TextEditingController Description = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File _imageFile;
  UserCredential authResult;
  final picker = ImagePicker();
  void submit() async {
    setState(() {
      isLoading = true;
      Map<String, dynamic> data = {
        "title": title.text,
        "Description": Description.text,
      };

      FirebaseFirestore.instance.collection("test1").add(data);
    });

    setState(() {
      isLoading = false;
    });
  }

  Widget _showImage() {
    if (_imageFile == null) {
      return Text("Image Please");
    } else if (_imageFile != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 150,
          ),
        ],
      );
    }
  }

  Future _getLocalImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 400,
    );

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: title,
      decoration: InputDecoration(
          labelText: "Title",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required';
        }
        if (value.length < 5 || value.length > 20) {
          return 'Title must be more than 5 and less than 20';
        }
        return null;
      },
      onSaved: (String value) {},
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: Description,
      maxLength: 500,
      maxLines: 3,
      decoration: InputDecoration(
          labelText: "Description",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required';
        }
      },
      onSaved: (String value) {},
    );
  }

  void validations() {
    if (title.text.isEmpty && Description.text.isEmpty) {
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Title & Descrition is empty"),
      ));
    } else if (title.text.isEmpty) {
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("title is empty"),
      ));
    } else if (Description.text.isEmpty) {
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Description is empty"),
      ));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => Submit()));
    }
  }

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      appBar: AppBar(
        title: Center(child: Text("Creates Reports")),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (ctx) => AllData()));
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                "Create Reports",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 16,
              ),
              _buildTitleField(),
              SizedBox(
                height: 16,
              ),
              _buildDescriptionField(),
              SizedBox(
                height: 16,
              ),
              ButtonTheme(
                child: RaisedButton(
                  onPressed: () {
                    _getLocalImage();
                  },
                  child: Text(
                    "Add Image",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              _showImage(),
              SizedBox(
                height: 10,
              ),
              isLoading == false
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          validations();

                          submit();
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
