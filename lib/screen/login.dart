import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'alldata.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  UserCredential authResult;

  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => AllData()));
    } on PlatformException catch (e) {
      String message = "Please check internet connection";
      if (e.message != null) {
        message = e.message.toString();
      }
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text(message.toString()),
      ));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void validations() {
    if (email.text.isEmpty && password.text.isEmpty) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Email & Password is empty")));
    } else if (email.text.isEmpty) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Email is empty")));
    } else if (password.text.isEmpty) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Password is empty")));
    } else {
      submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffold,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Login Page",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Text(
                  'Citizen App',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              isLoading == false
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                        child: Text('Login'),
                        color: Color(0xffEE7B23),
                        onPressed: () {
                          submit();
                          validations();
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
