// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// class CallPage extends StatefulWidget {
//   const CallPage({Key? key}) : super(key: key);

//   @override
//   _CallPageState createState() => _CallPageState();
// }

// class _CallPageState extends State<CallPage> {
//   ClientRole role = ClientRole.Broadcaster;
//   final _users = <int>[];
//   final _infoStrings = <String>[];
//   bool muted = false;
//   RtcEngine _engine;
//   bool _doctorJoined = false;
//   bool _doctorOffline = false;
//   bool _doctorEndedCall = false;
//   bool _doctorCameraActive = true;
//   bool _patientCameraActive = true;
//   bool _doctorPictureFrozen = false;

//   @override
//   void dispose() {
//     // clear users
//     _users?.clear();
//     // destroy sdk
//     _engine?.leaveChannel();
//     _engine?.destroy();

//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     // initialize agora sdk
//     initialize();

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       Wakelock.enable();
//       _updatePatientWaitingStatus(true);
//     });
//   }

//   _updatePatientWaitingStatus(bool isWaiting) {
//     final patient = Provider.of<Patient>(context, listen: false);
//     updatePatientWaitingStatus(patient, widget.appointment,
//         isWaiting: isWaiting);
//   }

//   Future<void> initialize() async {
//     if (widget.callData.appId.isEmpty) {
//       setState(() {
//         _infoStrings.add(
//           'AGORA_APP_ID missing, please provide your AGORA_APP_ID in settings.dart',
//         );
//         _infoStrings.add('Agora Engine is not starting');
//       });
//       return;
//     }

//     await _initAgoraRtcEngine();
//     _addAgoraEventHandlers();

//     //await _engine.enableWebSdkInteroperability(true);
//     VideoEncoderConfiguration configuration = VideoEncoderConfiguration();

//     configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
//     await _engine.setVideoEncoderConfiguration(configuration);
//     await _engine.joinChannel(widget.callData.agoraToken,
//         widget.callData.callId, widget.appointment.doctor.id, 0);
//   }

//   /// Create agora sdk instance and initialize
//   Future<void> _initAgoraRtcEngine() async {
//     _engine = await RtcEngine.create(widget.callData.appId);
//     await _engine.enableVideo();
//     await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
//     await _engine.setClientRole(role);
//   }

//   /// Add agora event handlers
//   void _addAgoraEventHandlers() {
//     _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
//       setState(() {
//         final info = 'aaaa***** onError: $code';
//         _infoStrings.add(info);
//       });
//     }, joinChannelSuccess: (channel, uid, elapsed) {
//       //messageToast(elapsed.toString());
//       setState(() {
//         final info = 'aaaa***** onJoinChannel: $channel, uid: $uid';
//         _infoStrings.add(info);
//         _doctorEndedCall = false;
//         _doctorOffline = false;
//       });
//     }, leaveChannel: (stats) {
//       setState(() {
//         _infoStrings.add('aaaa***** onLeaveChannel');
//         _users.clear();
//       });
//     }, userJoined: (uid, elapsed) {
//       setState(() {
//         final info = 'aaaa***** userJoined: $uid';
//         _infoStrings.add(info);
//         _users.add(uid);
//         _doctorJoined = true;
//         _doctorEndedCall = false;
//         _doctorOffline = false;
//       });
//     }, userOffline: (uid, elapsed) {
//       // messageToast(elapsed.toString());
//       switch (elapsed) {
//         case UserOfflineReason.Quit:
//           // call ended
//           _onCallEnd();
//           break;
//         case UserOfflineReason.Dropped:
//           // internet offline
//           setState(() {
//             _doctorOffline = true;
//           });
//           break;
//         default:
//       }
//       setState(() {
//         final info = 'userOffline: $uid';
//         _infoStrings.add(info);
//         _users.remove(uid);
//         _doctorJoined = true;
//       });
//     }, remoteVideoStateChanged:
//         (uid, videoRemoteState, videoRemoteStateReason, elapsed) {
//       switch (videoRemoteState) {
//         case VideoRemoteState.Stopped:
//           setState(() {
//             _doctorCameraActive = false;
//             _doctorPictureFrozen = false;
//           });

//           // messageToast('Doctor camera is Stopped ');
//           break;
//         case VideoRemoteState.Frozen:
//           setState(() {
//             _doctorPictureFrozen = true;
//             _doctorCameraActive = false;
//           });
//           //  messageToast('Doctor camera is Frozen');
//           break;
//         case VideoRemoteState.Failed:
//           setState(() {
//             _doctorCameraActive = false;
//           });
//           //  messageToast('Doctor camera is Failed');
//           break;
//         case VideoRemoteState.Starting:
//           setState(() {
//             _doctorCameraActive = true;
//             _doctorPictureFrozen = false;
//           });
//           //  messageToast('Doctor camera is Starting');
//           break;
//         case VideoRemoteState.Decoding:
//           setState(() {
//             _doctorCameraActive = true;
//           });
//           //  messageToast('Doctor camera is Decoding');
//           break;

//         default:
//       }
//     }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
//       setState(() {
//         final info = 'aaaa***** firstRemoteVideo: $uid ${width}x $height';
//         _infoStrings.add(info);
//       });
//     }));
//   }

//   /// Helper function to get list of native views
//   List<Widget> _getRenderViews() {
//     final List<StatefulWidget> list = [];
//     if (role == ClientRole.Broadcaster) {
//       list.add(RtcLocalView.SurfaceView());
//     }
//     _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
//     return list;
//   }

//   /// Video view wrapper
//   Widget _videoView(view) {
//     return Expanded(child: Container(child: view));
//   }

//   /// Video view row wrapper
//   Widget _expandedVideoRow(List<Widget> views) {
//     final wrappedViews = views.map<Widget>(_videoView).toList();
//     return Row(
//       children: wrappedViews,
//     );
//   }

//   _getDoctorStatusScreen(Widget view) {
//     if (_doctorJoined) {
//       if (_doctorOffline) {
//         return DoctorOfflineW(
//           doctor: widget.appointment.doctor,
//         );
//       } else if (_doctorCameraActive) {
//         return _expandedVideoRow([view]);
//       } else
//         return WaitingForDoctorW(
//           doctor: widget.appointment.doctor,
//           doctorJoined: _doctorJoined,
//           cameraActive: _doctorCameraActive,
//           doctorPictureFrozen: _doctorPictureFrozen,
//         );
//     } else {
//       return WaitingForDoctorW(
//         doctor: widget.appointment.doctor,
//         doctorJoined: _doctorJoined,
//         cameraActive: _doctorCameraActive,
//         doctorPictureFrozen: _doctorPictureFrozen,
//       );
//     }
//     return Container();
//   }

//   /// Video layout wrapper
//   Widget _viewRows() {
//     final views = _getRenderViews();

//     return Stack(
//       children: <Widget>[
//         views.length == 1
//             ? _getDoctorStatusScreen(Center())
//             : _getDoctorStatusScreen(views[1]),
//         _patientCameraActive
//             ? Container(
//                 alignment: Alignment.topRight,
//                 width: double.infinity,
//                 child: Container(
//                     margin: EdgeInsets.only(right: 10, top: 10),
//                     height: 150,
//                     decoration:
//                         BoxDecoration(borderRadius: BorderRadius.circular(18)),
//                     width: 101,
//                     child: Card(
//                         child:
//                             ClipRRect(child: _expandedVideoRow([views[0]])))),
//               )
//             : Center(),
//       ],
//     );
//   }

//   /// Confirm
//   _confirmLeave() {
//     showConfimMesage(context,
//             message: "Are you sure you want to end this consultation?".i18n,
//             titleText: 'Consultation end'.i18n)
//         .then((value) {
//       if (value == 1) _onCallEnd();
//     });
//   }

//   /// Toolbar layout
//   Widget _toolbar() {
//     double iconSize = 20;
//     if (role == ClientRole.Audience) return Container();
//     return Container(
//       alignment: Alignment.bottomCenter,
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(
//             width: 20,
//           ),
//           ToolBarButton(
//             child: Icon(
//               _patientCameraActive ? Icons.videocam : Icons.videocam_off,
//               color: Color(0xff444444),
//               size: iconSize,
//             ),
//             onTap: () {
//               setState(() {
//                 _patientCameraActive = !_patientCameraActive;
//               });
//               if (_patientCameraActive) {
//                 _engine.muteLocalVideoStream(false);
//               } else {
//                 _engine.muteLocalVideoStream(true);
//               }
//             },
//           ),
//           space(0, 8),
//           ToolBarButton(
//             child: Icon(
//               muted ? Icons.mic_off : Icons.mic,
//               color: Color(0xff444444),
//               size: iconSize,
//             ),
//             onTap: _onToggleMute,
//           ),

//           space(0, 8),
//           ToolBarButton(
//               child: Icon(
//                 Icons.switch_camera,
//                 color: Color(0xff444444),
//                 size: iconSize,
//               ),
//               onTap: _onSwitchCamera),
//           // RawMaterialButton(
//           //   onPressed: _onSwitchCamera,
//           //   child: Icon(
//           //     Icons.switch_camera,
//           //     color: MyColors.appMain100,
//           //     size: iconSize,
//           //   ),
//           //   shape: CircleBorder(),
//           //   elevation: 2.0,
//           //   fillColor: Colors.white,
//           //   padding: const EdgeInsets.all(12.0),
//           // ),
//           Spacer(),
//           ToolBarButton(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SvgPicture.asset(
//                 "assets/icons/teleconsultation/phone.svg",
//               ),
//             ),
//             onTap: () {
//               _confirmLeave();
//             },
//             backColor: Color(0xffff6d5f),
//           ),
//           // RawMaterialButton(
//           //   onPressed: () => _onCallEnd(),
//           //   child: SvgPicture.asset(
//           //     "assets/icons/teleconsultation/phone.svg",
//           //     width: 40,
//           //   ),
//           //   shape: CircleBorder(),
//           //   elevation: 2.0,
//           //   fillColor: Colors.redAccent,
//           //   padding: const EdgeInsets.all(10.0),
//           // ),
//           SizedBox(
//             width: 20,
//           ),
//         ],
//       ),
//     );
//   }

//   Future _onCallEnd() {
//     _updatePatientWaitingStatus(false);
//     _engine.leaveChannel();
//     Get.offAll(() => TeleAppointmentSucces());
//   }

//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     _engine.muteLocalAudioStream(muted);
//   }

//   void _onSwitchCamera() {
//     _engine.switchCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String langCode = getLocale(Localizations.localeOf(context));

//     return WillPopScope(
//       onWillPop: () {
//         _confirmLeave();
//         return;
//       },
//       child: Container(
//         color: Colors.white,
//         child: SafeArea(
//           top: false,
//           child: Scaffold(
//             backgroundColor: Colors.black,
//             body: Center(
//               child: Stack(
//                 children: <Widget>[
//                   _viewRows(),
//                   Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: Container(
//                         color: Colors.white,
//                         height: 124,
//                         padding: EdgeInsets.symmetric(horizontal: 40),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 40,
//                             ),
//                             Text(
//                               "%s%s %s".i18n.fill([
//                                 widget.appointment.doctor.title,
//                                 widget.appointment.doctor.firstName,
//                                 widget.appointment.doctor.lastName
//                               ]),
//                               style: TextStyle(
//                                 fontSize: 20.6,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'DMSans',
//                               ),
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Text(
//                               widget.appointment.doctor.getSpecialty(langCode),
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.grey.shade600),
//                             ),
//                           ],
//                         ),
//                       )),
//                   Positioned(bottom: 56, left: 0, right: 0, child: _toolbar()),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
