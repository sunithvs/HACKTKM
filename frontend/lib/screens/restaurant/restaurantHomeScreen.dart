import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/screens/restaurant/predictionForm.dart';
import 'package:hacktkm_frontend/screens/restaurant/productListing.dart';
import 'package:ionicons/ionicons.dart';

import '../../helpers/custom_colors.dart';
class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key});

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  List<Widget> screen = [
    const ProductListing(),
    const PredictionForm(),


  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        selectedIconTheme: IconThemeData(color: CustomColors.primaryColor),
        elevation: 10,
        currentIndex: index,
        showUnselectedLabels: true,
        selectedFontSize: size.width*.04,
        unselectedFontSize: size.width*.035,
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle: GoogleFonts.dmSans(color: Colors.black),
        unselectedLabelStyle: GoogleFonts.dmSans(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (val) {
          setState(() => index = val);
        },
        items:  [
          BottomNavigationBarItem(
              icon: Icon(
                Ionicons.home_outline,
              ),


              label: "Buy"),
          BottomNavigationBarItem(
              icon: Icon(
                  Ionicons.cube_outline
              ),
              label: "Predict"),


        ],
      ),
    );
  }
}
