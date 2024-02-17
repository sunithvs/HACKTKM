import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../models/poolingModel.dart';


class PoolingDetails extends StatelessWidget {
  const PoolingDetails(this.pooling,{super.key});
  final Pooling pooling;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width,
            height: size.height * .3,
            child: Image.network(
              pooling.imageUrl,
              fit: BoxFit.cover,
            ),

          ),
          SizedBox(height: size.height*.02,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*.05),
            child: Text(pooling.name,style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: size.width*.05),),
          ),
          SizedBox(height: size.height*.02,),
          Align(
            alignment: Alignment.centerRight,
            child: LinearPercentIndicator(
              width: size.width * .9,
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
              ),),
          ),
          SizedBox(height: size.height*.03,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*.05),
            child: Text(pooling.description,style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: size.width*.05),),
          ),
          Expanded(
            child: SizedBox(
              height: size.height * .4,
              child: WebViewWidget(controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(const Color(0x00000000))
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {},
                    onWebResourceError: (WebResourceError error) {},

                  ),
                )
                ..loadRequest(Uri.parse('https://www.google.com/maps/search/${pooling.lat},${pooling.long}?entry=tts'))),
            ),
          ),
          SizedBox(height: size.height*.02,),
          Center(
            child: ElevatedButton(onPressed: (){

            },style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.primaryColor,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.symmetric(horizontal: size.width*.2,vertical: size.height*.02),
                textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: size.width*.05)

            ), child: const Text('Contribute'),),
          ),
          SizedBox(height: size.height*.02,),

        ],
      ),
    );
  }
  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.data.toString());

  }
}
