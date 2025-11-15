class Meal {
  int id;
  String name;
  String imageUrl;

  Meal({required this.id, required this.name, required this.imageUrl});

  Meal.fromJson(Map<String, dynamic> data)
      : id = int.parse(data['idMeal']),
        name = data['strMeal'] ?? '',
        imageUrl = data['strMealThumb'] ?? '';
}
