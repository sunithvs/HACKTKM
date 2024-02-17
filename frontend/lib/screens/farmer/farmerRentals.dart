import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_colors.dart';
class FarmerRentals extends StatelessWidget {
  const FarmerRentals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        title:  Text('Rent Your equipments',style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return Card(
          child: ListTile(
            title: Text('Equipments'),
            subtitle: Text('Rent your equipments'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    itemCount: 10,)
    );
  }
}
