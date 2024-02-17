import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_route_animations.dart';
import 'package:hacktkm_frontend/models/poolingModel.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../helpers/custom_colors.dart';
import '../screens/farmer/pooling/poolingDetails.dart';

class PoolingCard extends StatelessWidget {
  const PoolingCard(this.pooling, {super.key});

  final Pooling pooling;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(SlidePageRoute(
          page: PoolingDetails(pooling),
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.width * .03, horizontal: size.width * .03),
        height: size.height * .2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                pooling.imageUrl,
                height: size.width * .3,
                width: size.width * .3,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: size.width * .03,
            ),
            SizedBox(
              width: size.width * .03,
            ),
            SizedBox(
              height: size.height * .2,
              width: size.width * .5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pooling.name,
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * .05),
                  ),
                  //

                  Text(
                    pooling.description,
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * .0425),
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),

                  LinearPercentIndicator(
                    width: size.width * .5,
                    lineHeight: size.height * .04,
                    animation: true,
                    barRadius: Radius.circular(20),
                   //fillColor: Color(0xffE8E8E8),
                    linearGradient: LinearGradient(
                      colors: [
                        CustomColors.primaryColor,
                        Color(0xff38E4E0)
                      ],
                    ),
                    backgroundColor: Color(0xffE8E8E8),
                    percent:
                        pooling.total_amount_received / pooling.total_amount,
                    //progressColor: CustomColors.primaryColor,
                    center: Text(
                      "\$${pooling.total_amount_received}/\$${pooling.total_amount}",
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * .04),
                    ),
                  ),
                  SizedBox(height: size.height*.02,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(

                        padding: EdgeInsets.symmetric(horizontal: size.width*.03,vertical: size.height*.01),
                        decoration: BoxDecoration(
                            color: CustomColors.primaryColor,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text("\$ ${pooling.total_amount.toString()}",style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: size.width*.04),)),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
