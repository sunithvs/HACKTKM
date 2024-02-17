import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../../helpers/custom_colors.dart';
import '../../../providers/rentalServices.dart';
class AddPooling extends StatefulWidget {
  const AddPooling({super.key});

  @override
  State<AddPooling> createState() => _AddPoolingState();
}

class _AddPoolingState extends State<AddPooling> {
  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  XFile? image;


  ImageProvider get imageProvider {
    if (image == null) {
      return const AssetImage("assets/images/avatar.png");
    } else {
      return FileImage(File(image!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mediaQuery.height * .3,
                width: mediaQuery.width,
                child: Image.asset(
                  "assets/images/rent.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: mediaQuery.height * .03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .05),
                child: Text(
                  "Add Pooling Request",
                  style: GoogleFonts.dmSans(
                      fontSize: mediaQuery.width * .07, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * .01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .05),
                child: Text(
                  "Show the power of community by pooling resources together",
                  style: GoogleFonts.dmSans(
                      fontSize: mediaQuery.width * .05, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * .03,
              ),
              Center(
                child: CircleAvatar(
                    radius: mediaQuery.width * .1,
                    backgroundImage: imageProvider),
              ),
              Center(
                child: TextButton(
                    onPressed: () async {
                      try {

                        image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (image != null) {
                          setState(() {});
                        }
                      } catch (error) {

                      }
                    },
                    child: Text(
                      "Add Photo",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: mediaQuery.width * .04,
                          color: CustomColors.primaryColor),
                    )),
              ),
              Form(
                key: _key,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .05),
                  height: mediaQuery.height * .3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 2) {
                              return "Invalid name";
                            } else {
                              return null;
                            }
                          },
                          style: GoogleFonts.nunitoSans(),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: Icon(
                                Icons.attractions,
                                color: CustomColors.primaryColor,
                              ),
                              hintText: "Name",
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),
                              fillColor: Colors.black12,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none)),
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: null,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return "Please Enter a valid description";
                            } else {
                              return null;
                            }
                          },
                          style: GoogleFonts.nunitoSans(),
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: Icon(
                                Ionicons.accessibility_outline,
                                color: CustomColors.primaryColor,
                              ),
                              hintText: "Product Description",
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),
                              fillColor: Colors.black12,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none)),
                        ),
                        TextFormField(
                          controller: _priceController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 2) {
                              return "Invalid price";
                            } else {
                              return null;
                            }
                          },
                          style: GoogleFonts.nunitoSans(),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: Icon(
                                Icons.attach_money,
                                color: CustomColors.primaryColor,
                              ),
                              hintText: "Total amount needed",
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),
                              fillColor: Colors.black12,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none)),
                        ),

                      ]),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * .03,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async{
                    Location location = new Location();


                    bool _serviceEnabled;
                    PermissionStatus _permissionGranted;
                    LocationData locationData;

                    _serviceEnabled = await location.serviceEnabled();
                    if (!_serviceEnabled) {
                      _serviceEnabled = await location.requestService();
                      if (!_serviceEnabled) {
                        return;
                      }
                    }

                    _permissionGranted = await location.hasPermission();
                    if (_permissionGranted == PermissionStatus.denied) {
                      _permissionGranted = await location.requestPermission();
                      if (_permissionGranted != PermissionStatus.granted) {
                        return;
                      }
                    }

                    locationData = await location.getLocation();
                    await Provider.of<RentalProvider>(context,listen: false).addPoolingItem(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      price: double.parse(_priceController.text),
                      image: File(image!.path),
                      lat: locationData.latitude??0.0,
                      long: locationData.longitude??0.0
                       );

                     Navigator.of(context).pop();

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.width * .1,
                          vertical: mediaQuery.height * .015),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text("Add Pooling Request",
                      style: GoogleFonts.poppins(
                          fontSize: mediaQuery.width * .04,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ));
  }
}
