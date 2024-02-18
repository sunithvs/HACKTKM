import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/services/predictionServices.dart';

import '../../helpers/custom_colors.dart';
class PredictionForm extends StatefulWidget {
  const PredictionForm({super.key});

  @override
  State<PredictionForm> createState() => _PredictionFormState();
}

class _PredictionFormState extends State<PredictionForm> {
  static const List<String> list = <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday','Friday','Saturday','Sunday'];
  String dropdownValue = 'Monday';
  bool events = false;
  final TextEditingController _sizeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:[
            SizedBox(
              height: size.height * .3,
              width: size.width,
              child: Image.asset(
                "assets/images/rent.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: Text(
                'Predict the demands for the week ahead',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500, fontSize: size.width * .05),
              ),
            ),
            Card(
              child: ListTile(
              
                //mainAxisAlignment: MainAxisAlignment.center,
                title:
                  Text(
                    'Select the day:',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500, fontSize: size.width * .05),
                  ),
                  trailing:
                  DropdownButton<String>(
              
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                    elevation: 16,
                    style:  const TextStyle(color: Colors.black,fontSize: 20),
                    underline: Container(
                      height: 2,
                      color: CustomColors.primaryColor,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
              
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Is there any events this week?',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500, fontSize: size.width * .05),
                ),
                trailing: Checkbox(
                  activeColor: CustomColors.primaryColor,
                  checkColor: Colors.black,
                  value: events,
                  onChanged: (bool? value) {
                    setState(() {
                      events = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            if(events)
              Card(
                child: ListTile(
                  title: Text(
                    'Size of Event:',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500, fontSize: size.width * .05),
                  ),
                  trailing: SizedBox(
                    width: size.width * .4,
                    child: TextField(
                      controller: _sizeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Size',
                        hintStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500, fontSize: size.width * .05),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: size.height * .02,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async{
                  await PredictionService.getPrediction(dropdownValue, events,_sizeController.text);
                  Navigator.pushNamed(context, '/predictionResult');
        
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
                  'Predict Now',
                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
                ),
              ),
            ),
        
        
        
        
        
        
          ]
        ),
      )
    );
  }
}

