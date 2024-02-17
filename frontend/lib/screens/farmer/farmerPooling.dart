import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_colors.dart';
import 'package:hacktkm_frontend/widgets/poolingCard.dart';
import 'package:provider/provider.dart';

import '../../providers/rentalServices.dart';
import '../../widgets/rentalCard.dart';
class FarmerPooling extends StatefulWidget {
  const FarmerPooling({super.key});

  @override
  State<FarmerPooling> createState() => _FarmerPoolingState();
}

class _FarmerPoolingState extends State<FarmerPooling> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<RentalProvider>(context,listen: false).fetchPoolings();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<RentalProvider>(context);
    final poolings = provider.poolings;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        title:  Text('Pool Equipment',style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,color: Colors.black87),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
      body:  poolings.isEmpty?
      Center(child: Text('No Pooling request Found',style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,fontSize: size.width*.05),),)
          :
      ListView.builder(itemBuilder: (context,index){
        return  PoolingCard(poolings[index]);
      },
        itemCount: poolings.length,),

    );
  }
}
