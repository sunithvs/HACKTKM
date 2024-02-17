import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/custom_colors.dart';

class FarmerProfile extends StatelessWidget {
  const FarmerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async{

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .1,
                      vertical: size.height * .015),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text("Add Rent Item",
                  style: GoogleFonts.poppins(
                      fontSize: size.width * .04,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
                onPressed: () async{

                  // Navigator.push(
                  //     context, SlidePageRoute(page: LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .1,
                        vertical: size.height * .015),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text("Add a Pooling",
                    style: GoogleFonts.poppins(
                        fontSize: size.width * .04,
                        color: Colors.black,
                        fontWeight: FontWeight.w600))),
          ],
        )
      ),

    );
  }
}
