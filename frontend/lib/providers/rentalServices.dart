import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/rentalModel.dart';
import 'package:http/http.dart' as http;

class RentalProvider extends ChangeNotifier{
   List<Rental> _rentals = [];
List<Rental> get rentals => _rentals;

  static const baseUrl = "http://farmer.radr.in/farmer";

  Future<void> fetchRentals() async {
    final url = Uri.parse("$baseUrl/rental-items/");
    print("fetching rentals");
    final response = await http.get(url);
    final data = json.decode(response.body)["results"] as List;
     List<Rental> loadedRentals = [];
     print(data.length);
     try{

       for (var i in data) {

         loadedRentals.add(Rental(
           name: i["name"],
           imageUrl: i["image"],
           description: i["description"],
           price: double.parse(i["rental_price_per_day"]),
           lat: i["location"]["lat"],
           long: i["location"]["long"],
         ));
       }
     }
      catch(e){
        print(e);
      }




    print("done fetching rentals");
    print(loadedRentals[0]);

    _rentals = loadedRentals;
    print(_rentals);
    notifyListeners();
  }
}
