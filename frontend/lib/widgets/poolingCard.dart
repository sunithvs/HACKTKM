import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_route_animations.dart';
import 'package:hacktkm_frontend/models/poolingModel.dart';
import 'package:hacktkm_frontend/screens/farmer/rentalDetails.dart';

import '../helpers/custom_colors.dart';
import '../models/rentalModel.dart';

class PoolingCard extends StatelessWidget {
  const PoolingCard(this.pooling,{super.key});
  final Pooling pooling;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        //Navigator.of(context).push(SlidePageRoute(page: RentalDetails(pooling),));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical:size.width*.03,horizontal: size.width*.03),
        height: size.height * .175,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                pooling.imageUrl,
                height: size.height * .175,
                width: size.width * .25,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: size.width * .03,
            ),
            SizedBox(
              height: size.height * .175,
              width: size.width * .6,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pooling.name,style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: size.width*.06),),
                  //SizedBox(height: size.height*.01,),

                  Expanded(child: Text(pooling.description,style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: size.width*.0425),overflow: TextOverflow.clip,)),
                  SizedBox(height: size.height*.02,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width*.03,vertical: size.height*.01),
                      decoration: BoxDecoration(
                          color: CustomColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("\$${pooling.total_amount.toString()}",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: size.width*.05),))
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
