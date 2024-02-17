import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hacktkm_frontend/models/poolingModel.dart';

import '../models/rentalModel.dart';
import 'package:http/http.dart' as http;

class RentalProvider extends ChangeNotifier {
  List<Rental> _rentals = [];

  List<Rental> get rentals => _rentals;
  List<Pooling> _poolings = [];

  List<Pooling> get poolings => _poolings;

  static const baseUrl = "http://farmer.radr.in";

  Future<void> fetchRentals() async {
    final url = Uri.parse("$baseUrl/farmer/rental-items/");
    print("fetching rentals");
    final response = await http.get(url);
    final data = json.decode(response.body)["results"] as List;
    List<Rental> loadedRentals = [];
    print(data.length);
    try {
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
    } catch (e) {
      print(e);
    }

    print("done fetching rentals");
    print(loadedRentals[0]);

    _rentals = loadedRentals;
    print(_rentals);
    notifyListeners();
  }

  Future<void> fetchPoolings() async {
    final url = Uri.parse("$baseUrl/pooling/pooling-items/");
    print("fetching rentals");
    final response = await http.get(url);
    final data = json.decode(response.body)["results"] as List;
    List<Pooling> loadedPoolings = [];
    print(data.length);
    try {
      for (var i in data) {
        loadedPoolings.add(Pooling(
          name: i["name"],
          imageUrl: i["image"],
          description: i["service_description"],
          lat: i["location"]["lat"],
          long: i["location"]["long"],
          total_amount: i["total_amount_requested'"],
          total_amount_received: i["total_amount_received"],
        ));
      }
    } catch (e) {
      print(e);
    }

    print("done fetching rentals");

    _poolings = loadedPoolings;

    notifyListeners();
  }
}
