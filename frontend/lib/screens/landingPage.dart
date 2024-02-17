import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_colors.dart';
import 'package:hacktkm_frontend/screens/farmer/FarmerHomeScreen.dart';
import 'package:hacktkm_frontend/screens/farmer/farmerRentals.dart';



import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_route_animations.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          //<-- SEE HERE
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .1,
            ),
            Image.asset(
              'assets/images/landing.jpg',
              width: size.width,
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .1),
              child: Text(
                'Elevating talent, \nSimplifying hiring',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: size.width * .065,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size.height * .025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .1),
              child: Text(
                'We help you find the right product for your business',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: size.width * .04,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: size.height * .06,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                child: Text(
                  'Who are You?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: size.width * .05,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: size.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("isFarmer", true);


                    Navigator.pushReplacement(context, SlidePageRoute(page: FarmerHomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * .1,
                          vertical: size.height * .015),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text("Farmer",
                      style: GoogleFonts.poppins(
                          fontSize: size.width * .04,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ),
                ElevatedButton(
                    onPressed: () async{
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isFarmer", false);

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
                    child: Text("Restaurant",
                        style: GoogleFonts.poppins(
                            fontSize: size.width * .04,
                            color: Colors.black,
                            fontWeight: FontWeight.w600))),
              ],
            )
          ],
        ),
      ),
    );
  }
}