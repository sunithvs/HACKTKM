import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_route_animations.dart';
import 'package:hacktkm_frontend/screens/farmer/rentals/rentalDetails.dart';

import '../helpers/custom_colors.dart';
import '../models/rentalModel.dart';

class RentalCard extends StatelessWidget {
  const RentalCard(this.rental,{super.key});
  final Rental rental;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(SlidePageRoute(page: RentalDetails(rental),));
      },
      child: Container(

        margin: EdgeInsets.symmetric(vertical:size.width*.01,horizontal: size.width*.04),
        height: size.height * .17,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                rental.imageUrl,
                height: size.width * .3,
                width: size.width * .3,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: size.width * .03,
            ),
            SizedBox(
              height: size.height * .155,
              width: size.width * .5,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(rental.name,style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: size.width*.05),),
                  //SizedBox(height: size.height*.01,),

                  Text(rental.description,style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: size.width*.035),overflow: TextOverflow.clip,),
                  SizedBox(height: size.height*.02,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width*.03,vertical: size.height*.01),
                      decoration: BoxDecoration(
                          color: CustomColors.primaryColor,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("\$ ${rental.price.toString()}",style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: size.width*.04),))
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
