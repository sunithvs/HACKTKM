import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/prediction.dart';
class PredictionService{
  static List<Prediction> predictions = [];
  static List<Prediction> ingredients = [];


  static Future<bool> getPrediction(String day,bool event,String eventCount) async {
    final url = Uri.parse('https://farmer.radr.in/rest/predictions/');
    // Simulate network request
    final response = await http.post(url, body: {
      "day": day,
      "event": event.toString(),
      "eventCount": eventCount
    });
    print(response.body);
    final predictionData = jsonDecode(response.body)["predictions"];
    List<Prediction> temp = [];
    for (var i in predictionData) {
      temp.add(Prediction(foodItem: i['food_item'], quantity: i['n_customers']+0.0));
    }
    predictions = temp;
 print(predictions);
    final ingredientData = jsonDecode(response.body)["ingredients"] as Map<String, dynamic>;
    List<Prediction> loadedIngredients = [];
    ingredientData.forEach((key, value) {
      loadedIngredients.add(Prediction(foodItem: key, quantity: value));
    });
    ingredients = loadedIngredients;
    print(ingredients);
    return true;




  }
}