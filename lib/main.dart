import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chatroom/Login/Authenticate.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Call.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authenticate(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final _channelController = TextEditingController();
  bool _validateError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("test Permistion"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 32,
                ),
                child: TextField(
                  controller: _channelController,
                  decoration: InputDecoration(labelText: "Meeting ID"),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 32,
                  ),
                  child: RaisedButton(
                    onPressed: jointMeeting,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        decoration: BoxDecoration(color: Colors.lightBlue),
                        width: 200,
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Center(
                            child: const Text('Join',
                                style: TextStyle(fontSize: 20)),
                          ),
                        )),
                  ))
            ],
          ),
        ));
  }

  Future<void> requestPermistion() async {
    await Permission.camera.request().isGranted;
    await Permission.microphone.request().isGranted;
  }

  Future<void> jointMeeting() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await requestPermistion();
      await Navigator.push(
          (context),
          MaterialPageRoute(
              builder: (context) => Call(
                    channelName: _channelController.text,
                  )));
    }
  }
}
