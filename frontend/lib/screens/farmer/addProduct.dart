import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacktkm_frontend/providers/productProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../helpers/custom_colors.dart';
class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  static const List<String> list = <String>['1', '2', '3', '4','5','6','7','8','9','10'];
  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  XFile? image;

  String dropdownValue = list.first;
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
                  "Add Product",
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
                  "Make your product available for the world",
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
                              prefixIcon: SizedBox(width: mediaQuery.width*.1,),

                              hintText: "Name",
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(color: Colors.black12,width: 1))),
                        ),
                        SizedBox(
                          height: mediaQuery.height * .03,
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
                              EdgeInsets.symmetric(vertical: mediaQuery.height*.1),
                              prefixIcon: SizedBox(width: mediaQuery.width*.1,),

                              hintText: "Product Description",
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black12,width: 1))),
                        ),
                        SizedBox(
                          height: mediaQuery.height * .03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [


                            SizedBox(

                              width: mediaQuery.width * .5,
                              child: TextFormField(
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
                                    prefixIcon: SizedBox(width: mediaQuery.width*.05,),
                                    hintText: "Price",
                                    hintStyle: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38),

                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.black12,width: 1)  )),
                              ),
                            ),
                            Text("Quantity",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500,fontSize: mediaQuery.width*.045),),
                            DropdownButton<String>(

                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                              elevation: 16,
                              style:  TextStyle(color: Colors.black),
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

                          ],
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


                    await Provider.of<ProductProvider>(context,listen: false).addProduct(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      price: double.parse(_priceController.text),
                      image: File(image!.path),
                      quantity: dropdownValue,);
                    Navigator.of(context).pop();

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.width * .25,
                          vertical: mediaQuery.height * .015),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300))),
                  child: Text("RENT OUT",
                      style: GoogleFonts.poppins(
                          fontSize: mediaQuery.width * .04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),

              ),
              SizedBox(
                height: mediaQuery.height * .03,
              ),
            ],
          ),
        ));
  }
}
