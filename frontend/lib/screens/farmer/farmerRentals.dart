import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_colors.dart';
import 'package:hacktkm_frontend/providers/rentalServices.dart';
import 'package:hacktkm_frontend/widgets/rentalCard.dart';
import 'package:provider/provider.dart';
class FarmerRentals extends StatefulWidget {
  const FarmerRentals({super.key});

  @override
  State<FarmerRentals> createState() => _FarmerRentalsState();
}

class _FarmerRentalsState extends State<FarmerRentals> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<RentalProvider>(context,listen: false).fetchRentals();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RentalProvider>(context);
    final rentals = provider.rentals;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        title:  Text('Rent Your equipments',style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,color: Colors.black87),),
      ),
      body:

          rentals.isEmpty?
              Center(child: Text('No Rentals Found',style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,fontSize: size.width*.05),),)
          :
           ListView.builder(itemBuilder: (context,index){
            return  RentalCard(rentals[index]);
          },
              itemCount: rentals.length,)

    );
  }
}
