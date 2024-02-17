import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../models/rentalModel.dart';

class RentalDetails extends StatelessWidget {
  const RentalDetails(this.rental, {super.key});

  final Rental rental;

  @override
  Widget build(BuildContext context) {
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
              rental.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Text(
              rental.name,
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
              "\$${rental.price.toString()}",
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600, fontSize: size.width * .045),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ), Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Text(
              rental.description,
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w500, fontSize: size.width * .04),
            ),
          ),
          SizedBox(height: size.height*.03,),
          Center(
            child: ElevatedButton(
              onPressed: () {},
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
                '\$ Rent Now',
                style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .03,
          ),
          Divider(
            endIndent: size.width * .1,
            indent: size.width * .08,
          ),
          SizedBox(
            height: size.height * .03,
          ),



          Expanded(
            child: SizedBox(
              height: size.height * .4,
              child: WebViewWidget(
                  controller: WebViewController()
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
                    ..loadRequest(Uri.parse(
                        'https://www.google.com/maps/search/${rental.lat},${rental.long}?entry=tts'))),
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
        ],
      ),
    );
  }
}
