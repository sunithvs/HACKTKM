

import 'package:flutter/material.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../helpers/custom_colors.dart';
import '../models/message.dart';





class ChatBubble extends StatelessWidget {
  ChatBubble({required this.message, Key? key}) : super(key: key);
  final Message message;


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isCurrentUser?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(mediaQuery.height*.01),
          padding: EdgeInsets.symmetric(horizontal:mediaQuery.width*.03,vertical: mediaQuery.height*.01),
          alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(
              color: isCurrentUser?CustomColors.primaryColor:Colors.black45,
              borderRadius: isCurrentUser
                  ? const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
                  : const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: VoiceMessageView(


            size:40,

            controller: VoiceController(
              audioSrc:
              message.path,
              maxDuration: const Duration(seconds: 10),
              isFile: false,
              onComplete: () {
                /// do something on complete
              },
              onPause: () {
                /// do something on pause
              },
              onPlaying: () {
                /// do something on playing
              },
              onError: (err) {
                /// do somethin on error
              },
            ),
            innerPadding: 12,
            cornerRadius: 20,
            circlesColor: CustomColors.primaryColor,
            activeSliderColor: CustomColors.primaryColor,
          ),
        ),
      ],
    );
  }

  bool  get isCurrentUser  {
    return message.role == "user";
  }
}