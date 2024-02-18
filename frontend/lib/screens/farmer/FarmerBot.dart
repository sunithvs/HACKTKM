import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../helpers/custom_colors.dart';
import '../../providers/chatProvider.dart';
import '../../widgets/messageList.dart';
class FarmerBot extends StatefulWidget {
   FarmerBot({super.key});

  @override
  State<FarmerBot> createState() => _FarmerBotState();
}

class _FarmerBotState extends State<FarmerBot> {
   bool isRecording = false;
   bool isLoading = false;
   final recorder = FlutterSoundRecorder();
   @override
  void initState() {
    // TODO: implement initState
     initRecorder();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),


        elevation: 5,
        backgroundColor: CustomColors.primaryColor,
        title: Text(
          "Farmsta",
          style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(

        highlightElevation: 10,

        onPressed: () async{

          if(recorder.isRecording){
           final path = await recorder.stopRecorder();
           final audioFile = File(path!);
            setState(() {
              isRecording = false;
              isLoading = true;
            });

            await provider.sendMessage(audioFile);
            setState(() {
              isLoading = false;
            });
          }else{
            await recorder.startRecorder(toFile: "audio");
            setState(() {
              isRecording = true;
            });
          }




        },
        shape: const CircleBorder(),
        backgroundColor: CustomColors.primaryColor,
        child:  isRecording?Icon(Ionicons.stop_circle,color: Colors.red,):Icon(Ionicons.mic,size: size.width*.1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: isLoading?Center(
        child: SizedBox(
          width: size.width,

            child: Lottie.asset("assets/images/animation.json",fit: BoxFit.fitWidth)),
      ): MessagesList(),
    );
  }
  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await recorder.openRecorder();
  }
}
