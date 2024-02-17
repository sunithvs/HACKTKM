import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/helpers/custom_colors.dart';
import 'package:hacktkm_frontend/widgets/poolingCard.dart';
import 'package:provider/provider.dart';

import '../../../providers/rentalServices.dart';
import '../../../widgets/rentalCard.dart';
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
        elevation: 0,
        flexibleSpace: Image.asset('assets/images/img_1.png',fit: BoxFit.cover,width: size.width,),



        toolbarHeight: size.height*.15,
        title:  Text('Pool Equipment',style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,color: Colors.black87),),
        actions: [
          ElevatedButton.icon(onPressed: (){
            Navigator.of(context).pushNamed('/addPooling');
          }, label: Text('Add Rental',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,color: Colors.black87,fontSize: size.width*.04),),
              icon: Icon(Icons.add)),
          SizedBox(width: size.width*.02,)
        ],
      ),
      body:  poolings.isEmpty?
      Center(child: Text('No Pooling request Found',style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,fontSize: size.width*.05),),)
          :
      ListView.builder(itemBuilder: (context,index){
        return  Column(
          children: [
            PoolingCard(poolings[index]),
            Divider(endIndent: size.width*.1,indent: size.width*.1,color: Colors.black12,)

          ],
        );
      },
        itemCount: poolings.length,),

    );
  }
}
