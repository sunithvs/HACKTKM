import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../helpers/custom_colors.dart';
import '../../providers/chatProvider.dart';
import '../../widgets/messageList.dart';
class FarmerBot extends StatelessWidget {
  const FarmerBot({super.key});

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
          "Skin Sure",
          style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(

        highlightElevation: 10,

        onPressed: () {

        },
        shape: CircleBorder(),
        child:  Icon(Ionicons.mic,size: size.width*.1),
        backgroundColor: CustomColors.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: MessagesList(),
    );
  }
}
