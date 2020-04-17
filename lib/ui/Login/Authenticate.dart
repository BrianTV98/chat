import 'package:chatroom/ui/Register/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  final userNameControler = TextEditingController();
  final passWordControler = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  State<StatefulWidget> createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  String email;
  bool success = false;
  bool validPassword = true; // =false when password empty
  int auth = -1;
  bool isEmail = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            TextInputEmail(),
            TextInputPassowrd(),
            Center(
              child: Text(
                (auth == 1) ? "Tên đăng nhập hoặc mật khẩu sai" : "",
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            LoginButton("ui.Login", Colors.white, Colors.blueAccent),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              child: Text(
                "Create one account",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget TextInputEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 32,
      ),
      child: TextField(
        controller: widget.userNameControler,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(),
            errorText: isEmail ? null : "Email không hợp lệ"),
      ),
    );
  }

  Widget TextInputPassowrd() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 32,
      ),
      child: TextField(
        obscureText: true,
        controller: widget.passWordControler,
        decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(),
            errorText:
            (!validPassword) ? "Password không được để trống" : null),
      ),
    );
  }

  Widget LoginButton(String lable, Color textColor, Color BgColor) {
    return MaterialButton(
      onPressed: valid,
      textColor: textColor,
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: BgColor),
        child: Center(
          child: Text(
            lable,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  void valid() {
    if (widget.passWordControler.text.isEmpty) {
      setState(() {
        validPassword = false;
      });
    } else
      setState(() {
        validPassword = true;
      });

    if (validateEmail(widget.userNameControler.text.trim())) {
      setState(() {
        isEmail = true;
      });
    } else
      setState(() {
        isEmail = false;
      });

    if (widget.passWordControler.text.isNotEmpty &&
        validateEmail(widget.userNameControler.text.trim())) {
      _signInWithEmailAndPassword();
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  void _signInWithEmailAndPassword() async {
    print("userName " + widget.userNameControler.text.trim() + ";");
    print("password " + widget.passWordControler.text + ";");

    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: widget.userNameControler.text.trim(),
          password: widget.passWordControler.text.trim());
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {
      print(e.toString());
      setState(() {
        auth = 1;
      });
    }
  }

}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("List Friend"),
      ),
    );
  }
}
