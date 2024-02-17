import 'dart:io';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/screens/farmer/farmerRentals.dart';

import 'package:ionicons/ionicons.dart';
import '../../helpers/custom_colors.dart';


class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({Key? key}) : super(key: key);

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {


  List<Widget> screen = [
    const FarmerRentals(),

  ];

  int index = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        selectedIconTheme: IconThemeData(color: CustomColors.primaryColor),
        elevation: 10,
        currentIndex: index,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.shifting,
        onTap: (val) {
          setState(() => index = val);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                index == 0 ? Ionicons.home_sharp : Ionicons.home_outline,
              ),
              label: " "),
          BottomNavigationBarItem(
              icon: Icon(
                index == 1 ? Ionicons.search_sharp : Ionicons.search_outline,
              ),
              label: " "),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () async {

                  },
                  icon: const Icon(
                    Ionicons.add_circle_outline,
                    size: 30,
                  )),
              label: " "),
          const BottomNavigationBarItem(
              icon: Icon(Ionicons.person_circle_outline), label: " "),
          const BottomNavigationBarItem(
              icon: Icon(
                Ionicons.settings_outline,
              ),
              label: " ")
        ],
      ),
    );
  }


}