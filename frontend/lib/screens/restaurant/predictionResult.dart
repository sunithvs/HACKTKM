import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/services/predictionServices.dart';

class PredictionResult extends StatelessWidget {
   PredictionResult({super.key});

  final predictions = PredictionService.predictions;
  final ingredients = PredictionService.ingredients;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
                children: [
                  SizedBox(height: size.height*.04,),
                  Text("Predictions",style: GoogleFonts.dmSans(fontSize: size.width*.07,fontWeight: FontWeight.bold),),
                  SizedBox(height: size.height*.03,),

          SizedBox(

            height: size.height * .3,
            child: ListView.builder(

    itemBuilder: (ctx,index){
              return Card(
                child: ListTile(
                  title: Text("Item: ${predictions[index].foodItem}",style: GoogleFonts.dmSans(fontSize: size.width*.05,fontWeight: FontWeight.w600),),
                  trailing: Text(predictions[index].quantity.toString(),style: GoogleFonts.dmSans(fontSize: size.width*.05,fontWeight: FontWeight.w600),),
                ),
              );
            },
              itemCount: predictions.length,
            ),

          ),
                  SizedBox(height: size.height*.04,),
                  Text("Ingredients",style: GoogleFonts.dmSans(fontSize: size.width*.07,fontWeight: FontWeight.bold),),
                  SizedBox(height: size.height*.03,),

                  SizedBox(

                    height: size.height * .3,
                    child: ListView.builder(

                      itemBuilder: (ctx,index){
                        return Card(
                          child: ListTile(
                            title: Text("Ingredient: ${ingredients[index].foodItem}",style: GoogleFonts.dmSans(fontSize: size.width*.045,fontWeight: FontWeight.w600),),
                            trailing: Text("${ingredients[index].quantity.round()}Kg",style: GoogleFonts.dmSans(fontSize: size.width*.04,fontWeight: FontWeight.w600),),
                          ),
                        );
                      },
                      itemCount: ingredients.length,
                    ),

                  ),

                ],
              ),
        ));
  }
}
