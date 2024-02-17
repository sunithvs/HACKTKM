import 'package:flutter/material.dart';
import 'package:hacktkm_frontend/providers/chatProvider.dart';
import 'package:hacktkm_frontend/providers/rentalServices.dart';
import 'package:hacktkm_frontend/screens/farmer/FarmerBot.dart';
import 'package:hacktkm_frontend/screens/farmer/addRental.dart';
import 'package:hacktkm_frontend/screens/landingPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const HackTKM());
}

class HackTKM extends StatelessWidget {
  const HackTKM({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<RentalProvider>(create: (context) => RentalProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider()),
    ],
        child:  MaterialApp(
          routes: {
            '/addRental': (context) =>  AddRental(),
          },
          debugShowCheckedModeBanner: false,
          home: LandingPage(),
        ));

  }
}
