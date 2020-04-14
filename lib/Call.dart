import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chatroom/utils.dart';
import 'package:flutter/material.dart';

class Call extends StatefulWidget {
  final String channelName;

  const Call({Key key, this.channelName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CallState();
}

class CallState extends State<Call> {
  static final _users = <int>[];
  final _inforString = <String>[];
  bool muted = false;

  bool state_video = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initalize();
  }

  @override
  void dispose() {
    // được gọi khi vòng đời State bị  destroy
    // TODO: implement dispose
    _users.clear();
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  Future<void> initalize() async {
    await _initAgoraRtcEngine();
    _addAgoraEventEngine();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters( //chua hieu cac tham so truyen vao
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.joinChannel(
        null, widget.channelName, null, 0); //?? Cac doi so truyen vao
  }

  _initAgoraRtcEngine() async {
    AgoraRtcEngine.setEncryptionMode('aes-128-xts');
    AgoraRtcEngine.setEncryptionSecret('ourSecret');
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
    await AgoraRtcEngine.enableAudio();
  }

  void _addAgoraEventEngine() {
    AgoraRtcEngine.onError = (dynamic code) {
      // nếu xẩy ả lỗi
      setState(() {
        final info = 'onError : $code';
        _inforString.add(info);
      });
    };
    AgoraRtcEngine.onJoinChannelSuccess = (String channel,
        int uid,
        int elapsed,) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _inforString.add(info);
      });
    };
    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _inforString.add('onLeaveChannel');
        _users.clear();
      });
    };
    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _inforString.add(info);
        _users.add(uid);
      });
    };
    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        _inforString.add(info);
        _users.remove(uid);
      });
    };
    AgoraRtcEngine.onFirstRemoteVideoFrame = (int uid,
        int width,
        int height,
        int elapsed,) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _inforString.add(info);
      });
    };
  }

  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [
      AgoraRenderWidget(0, local: true, preview: true),
    ];
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }

  Widget _videoView(view) {
    return Expanded(
      child: Container(
        child: view,
      ),
    );
  }

  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map(_videoView).toList();
    return Expanded(
      child: Row(children: wrappedViews),
    );
  }

  Widget _viewRows() {
    // chia view len mang hinh
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
          child: Column(
            children: <Widget>[
              _videoView(views[0]),
            ],
          ),
        );
      case 2:
        return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow([views[0]]),
              _expandedVideoRow([views[1]]),
            ],
          ),
        );
      case 3:
        return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow(views.sublist(0, 2)), // chua hieu cach chia
              _expandedVideoRow(views.sublist(2, 3))
            ],
          ),
        );
      case 4:
        return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow(views.sublist(0, 2)), // chua hieu cach chia
              _expandedVideoRow(views.sublist(2, 4))
            ],
          ),
        );
      default:
    }
    return Container();
  }

  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _inforString.length,
            itemBuilder: (BuildContext context, int index) {
              if (_inforString.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "so nguoi" + _getRenderViews().length.toString(),
                          //_inforString[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _toobar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToogleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.red,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onToogleCarmera,
            child: Icon(
              state_video ? Icons.videocam : Icons.videocam_off,
              size: 20,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Call'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            //_panel(),
            _toobar(),
            _switchCamera(),
          ],
        ),
      ),
    );
  }

  void _onToogleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  void _onToogleCarmera() {
    setState(() {
      state_video = !state_video;
    });
    if (state_video) {
      AgoraRtcEngine.enableVideo();
    }
    else
      AgoraRtcEngine.disableVideo();
  }

  Widget _switchCamera() {
    return Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.symmetric(vertical: 48),
      child:  RawMaterialButton(
        onPressed: _onSwitchCamera,
        child: Icon(
          Icons.switch_camera,
          color: Colors.blueAccent,
          size: 20,
        ),
        shape: CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.white,
        padding: const EdgeInsets.all(12.0),
      ),
    );
  }
}
