import 'dart:io';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/screens/farmer/FarmerBot.dart';
import 'package:hacktkm_frontend/screens/farmer/pooling/farmerPooling.dart';
import 'package:hacktkm_frontend/screens/farmer/rentals/farmerRentals.dart';

import 'package:ionicons/ionicons.dart';
import '../../helpers/custom_colors.dart';
import 'farmerProfile.dart';


class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({Key? key}) : super(key: key);

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {


  List<Widget> screen = [
    const FarmerRentals(),
    const FarmerPooling(),
    const FarmerProfile(),
    const FarmerBot()

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


              label: "Rent"),
          BottomNavigationBarItem(
              icon: Icon(
                Ionicons.cube_outline
              ),
              label: "Pool"),

          BottomNavigationBarItem(
              icon: Icon(Ionicons.cart_outline), label: "Sell"),
          BottomNavigationBarItem(
              icon: Icon(
                Ionicons.chatbox_ellipses_outline,
              ),
              label: "Chat")
        ],
      ),
    );
  }


}