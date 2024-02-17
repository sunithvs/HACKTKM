import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helpers/custom_colors.dart';
import '../../providers/productProvider.dart';
class ProductListing extends StatefulWidget {
  const ProductListing({super.key});

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final products = provider.products;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Image.asset(
            'assets/images/img_1.png',
            fit: BoxFit.cover,
            width: size.width,
          ),
          toolbarHeight: size.height * .15,
          title: Text(
            'MarketPlace',
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w600, color: Colors.black87),
          ),

        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),

            itemCount: products.length,
            itemBuilder: (ctx, index) {
              return SizedBox(
                height: size.height * .3,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          products[index].imageUrl,
                          fit: BoxFit.cover,
                          height: size.height * .15,
                          width: size.width * .4,
                        )),
                    Text(
                      products[index].name,
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * .05),
                    ),
                    Container(

                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .03,
                            vertical: size.height * .01),
                        decoration: BoxDecoration(
                            color: CustomColors.primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "\$ ${products[index].price.toString()}",
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * .04),
                        )),
                  ],
                ),
              );
            }));
  }
}
