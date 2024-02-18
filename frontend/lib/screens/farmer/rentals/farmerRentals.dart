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
      extendBodyBehindAppBar: true,


      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Image.asset('assets/images/img_1.png',fit: BoxFit.cover,width: size.width,),


        
        toolbarHeight: size.height*.15,
        backgroundColor: CustomColors.primaryColor.withOpacity(0),
        title:  Text('Rental',style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,color: Colors.black87,fontSize: size.width*.06),),
        actions: [
          ElevatedButton.icon(onPressed: (){
            Navigator.of(context).pushNamed('/addRental');
          }, label: Text('Add Rental',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,color: Colors.black87,fontSize: size.width*.04),),
              icon: Icon(Icons.add)),
          SizedBox(width: size.width*.02,)
        ],

      ),
      body:

          rentals.isEmpty?
              Center(child: Text('No Rentals Found',style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,fontSize: size.width*.05),),)
          :
           ListView.builder(itemBuilder: (context,index){
            return  Column(
              children: [
                RentalCard(rentals[index]),
                Divider(endIndent: size.width*.1,indent: size.width*.1,color: Colors.black12,)
              ],
            );
                     },
              itemCount: rentals.length,)

    );
  }
}
