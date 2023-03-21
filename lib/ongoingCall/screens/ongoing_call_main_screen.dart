import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doctovirt/elements/custom_inkwell.dart';
import 'package:doctovirt/them/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../helper/dialogs.dart';
import '../widgets/tool_bar_button.dart';

/// The agora app id
const appId = "85559cb7b6bb4bd9b8725f1fae06a4ba";

/// The chanel name (Should change in production)
const channel = "virtaul-test-1679141085";

class OngoingCallMainScreen extends StatefulWidget {
  final String token;
  const OngoingCallMainScreen({Key? key, required this.token})
      : super(key: key);

  @override
  State<OngoingCallMainScreen> createState() => _OngoingCallMainScreenState();
}

class _OngoingCallMainScreenState extends State<OngoingCallMainScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;
  bool cameraActive = true;
  bool patientCameraActive = true;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  void dispose() {
    _engine.release();
    super.dispose();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          if (mounted) {
            setState(() {
              _localUserJoined = true;
            });
          }
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          if (mounted) {
            setState(() {
              _remoteUid = remoteUid;
            });
          }
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          if (mounted) {
            setState(() {
              _remoteUid = null;
            });
          }
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: widget.token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
    setState(() {});
  }

  _confirmLeave() {
    showConfimMesage(
      context,
      message: "Are you sure you want to end this consultation?",
      titleText: 'Consultation end',
      buttonConfirm: 'End',
    ).then((value) {
      if (value == 1) _onCallEnd();
    });
  }

  _onCallEnd() async {
    setState(() {
      _localUserJoined = false;
      _remoteUid = null;
    });
    await _engine.leaveChannel();
    Get.back();
  }

  _disableCamera() {
    setState(() {
      patientCameraActive = !patientCameraActive;
    });

    _engine.enableLocalVideo(!patientCameraActive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 150,
              margin: const EdgeInsets.all(12),
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ToolBarButton(
                    onTap: () {
                      _onToggleMute();
                    },
                    child: Icon(
                      muted ? Icons.mic_off : Icons.mic,
                      color: muted
                          ? const Color(0xff444444)
                          : AppColors.appMain100,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ToolBarButton(
                    onTap: () {
                      _onSwitchCamera();
                    },
                    child: const Icon(
                      Icons.switch_camera_outlined,
                      color: AppColors.appMain100,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ToolBarButton(
                    onTap: () {
                      _disableCamera();
                    },
                    child: Icon(
                      patientCameraActive ? Icons.videocam : Icons.videocam_off,
                      color: patientCameraActive
                          ? AppColors.appMain100
                          : const Color(0xff444444),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ToolBarButton(
                    onTap: () {
                      _confirmLeave();
                    },
                    child: SvgPicture.asset(
                      'assets/phone.svg',
                      color: AppColors.red235,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/doctoVirt.png",
            width: 220,
          ),
          const SizedBox(height: 20),
          const Text(
            'Please wait for remote user to join',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    }
  }
}
