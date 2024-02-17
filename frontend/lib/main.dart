import 'package:flutter/material.dart';
import 'package:hacktkm_frontend/providers/chatProvider.dart';
import 'package:hacktkm_frontend/screens/farmer/FarmerBot.dart';
import 'package:hacktkm_frontend/screens/landingPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const HackTKM());
}

class HackTKM extends StatelessWidget {
  const HackTKM({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (context) => ChatProvider(),
      builder: (context,child) {
        return MaterialApp(
          home: LandingPage(),
        );
      }
    );
  }
}
