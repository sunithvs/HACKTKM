import 'dart:convert';
import 'dart:io';

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
  Future<void> addRentItem(
      {required String name,
      required String description,
      required String quantity,
      required double price,
        required File image,
      required double lat,
      required double long}) async {
    final url = Uri.parse("$baseUrl/farmer/rental-items/");
    final request = http.MultipartRequest('POST', url);
    final data = {
      "name": name,
      "description": description,
      "available_quantity":quantity,
      "category_name":"agriculture",
      "rental_price_per_day": price.toString(),
      "location_lat": lat.toString(),
      "location_long": long.toString()
    };
    request.fields.addAll(data);
    final bytes = await image.readAsBytes();
    request.files.add(http.MultipartFile.fromBytes("image", bytes,
        filename: image.path.split("/").last));
    var response = await request.send();

    final value = await response.stream.bytesToString();
    final responseData = jsonDecode(value);

  }

  Future<void> fetchPoolings() async {
    final url = Uri.parse("$baseUrl/pooling/pooling-items/");
    print("fetching rentals");
    final response = await http.get(url);
    final data = json.decode(response.body)["results"] as List;
    List<Pooling> loadedPoolings = [];
    print(data.length);
    print(data[0]);
    try {
      for (var i in data) {
        print((i["location"]["lat"]));
        loadedPoolings.add(Pooling(
          name: i["name"],
          imageUrl: i["image"],
          description: i["service_description"],
          lat: i["location"]["lat"] as double,
          long: i["location"]["long"],
          total_amount: double.parse(i["total_amount_requested"]),
          total_amount_received: double.parse(i["total_amount_received"]),
        ));
      }
    } catch (e) {
      print(e);
    }

    print("done fetching pooling");

    _poolings = loadedPoolings;

    notifyListeners();
  }

  Future<void> addPoolingItem(
      {required String name,
        required String description,

        required double price,
        required File image,
        required double lat,
        required double long}) async {
    final url = Uri.parse("$baseUrl/pooling/pooling-items/");
    final request = http.MultipartRequest('POST', url);
    final data = {
      "name": name,
      "service_description": description,

      "region":"kilikolloor",
      "total_amount_requested": price.toString(),
      "location_lat": lat.toString(),
      "location_long": long.toString()
    };
    request.fields.addAll(data);
    final bytes = await image.readAsBytes();
    request.files.add(http.MultipartFile.fromBytes("image", bytes,
        filename: image.path.split("/").last));
    var response = await request.send();

    final value = await response.stream.bytesToString();
    final responseData = jsonDecode(value);

  }



}
