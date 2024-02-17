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
    final mediaQuery = MediaQuery.of(context).size;
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
      body: Column(
        children: [
          const Expanded(child: MessagesList()),
          Container(

            height: mediaQuery.height * .1,
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .01),
            child: Row(
              children: [
                SizedBox(
                  width: mediaQuery.width * .8,
                  child: SizedBox()
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 20, right: 15, bottom: 15, top: 15),
                        backgroundColor: CustomColors.primaryColor,
                        shape: const CircleBorder()),
                    onPressed: () {

                    },
                    child: const Icon(
                      Ionicons.send_sharp,
                      color: Colors.white,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
