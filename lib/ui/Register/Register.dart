import 'dart:io';

import 'package:chatroom/ui/Login/Authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  bool isEmail = true;
  bool isPassword = true; // # ""
  bool confirmPasswordSuccess = true;
  bool _isRegisterSuccess =false;
  File _image;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ui.Register"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){
//                ImagePicker.pickImage(source: ImageSource.gallery);
              },
              child: CircleAvatar(
                backgroundImage: (_image!=null)? NetworkImage(_image.toString()) : AssetImage('assets/images/mytam.jpg'),
                radius: 50,
              ),
            ),
            InputEmail(),
            InputPassword(),
            InputConfirmPassword(),
            ButtonRegister(),
          ],
        ),
      ),
    );
  }
//  Future getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      _image = _image;
//    });
//
//  }

  Widget InputEmail() {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 32,
        ),
        child: TextField(
          controller: _emailController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
              errorText: isEmail ? null : "Email khong hop le"),
        ));
  }

  Widget InputPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: TextField(
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Password",
            errorText: isPassword ? null : "Password phải lớn hơn 6 kí tự"),
      ),
    );
  }

  Widget InputConfirmPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: TextField(
        controller: _confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "ConfirmPassword",
            errorText:
                confirmPasswordSuccess ? null : " Xac nhan lai password"),
      ),
    );
  }

  Widget ButtonRegister() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: MaterialButton(
        onPressed: RegisterAccount,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: Center(
              child: Text(
            "Register",
            style: TextStyle(color: Colors.white),
          )),
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  bool validateRegister() {
    if (validateEmail(_emailController.text.trim())) {
      setState(() {
        isEmail = true;
      });
    } else {
      setState(() {
        isEmail = false;
      });
      return false;
    }
    if (_passwordController.text.length > 5 &&
        _passwordController.text.length < 32) {
      setState(() {
        isPassword = true;
      });
    } else {
      setState(() {
        isPassword = false;
      });
      return false;
    }
    if (_confirmPasswordController.text == _passwordController.text) {
      setState(() {
        confirmPasswordSuccess = true;
      });
    } else {
      setState(() {
        confirmPasswordSuccess = false;
      });
      return false;
    }

    return true;
  }

  Future<void> RegisterAccount() async {
    if (validateRegister()) {
      final FirebaseUser user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ))
              .user;
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    }
  }

  bool validateEmail(String value) {
    // return true if is Email , else reture false
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }
  
}
