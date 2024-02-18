import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../models/rentalModel.dart';
import '../../models/product.dart';

class ProductDetails extends StatelessWidget {
   ProductDetails(this.product, {super.key});


  final Product product;

  @override
  Widget build(BuildContext context) {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': product.price,
      'name': 'Farmsta Corp.',
      'description': product.name,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width,
            height: size.height * .3,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Text(
              product.name,
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600, fontSize: size.width * .06),
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Text(
              "\$${product.price.toString()}",
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600, fontSize: size.width * .045),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ), Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Text(
              product.description,
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w500, fontSize: size.width * .04),
            ),
          ),
          SizedBox(height: size.height*.03,),
          Center(
            child: ElevatedButton(
              onPressed: () {
                final razorPay = Razorpay();
                razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Payment Successful'),
                    backgroundColor: CustomColors.primaryColor,
                  ));
                  Navigator.pop(context);
                });
                razorPay.open(options);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .3,
                      vertical: size.height * .015),
                  textStyle: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700, fontSize: size.width * .05)),
              child: Text(
                '\$ Buy Now',
                style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
