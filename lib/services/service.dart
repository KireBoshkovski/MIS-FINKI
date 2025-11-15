import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:helloworld/models/category.dart';
import 'package:helloworld/models/meal.dart';

import '../models/meal_details.dart';

class Service {
  Future<List<Category>> loadCategories() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categoriesJson = data['categories'];
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Meal>> loadMealsForCategory(String category) async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List mealsJson = data['meals'];
      return mealsJson.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals for category: $category');
    }
  }

  Future<MealDetails?> loadMealDetailsById(int id) async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MealDetails.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load meal details for id: $id');
    }
  }

  Future<MealDetails> loadRandomMeal() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MealDetails.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load random meal');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List mealsJson = data['meals'];
      return mealsJson.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals for query: $query');
    }
  }
}
