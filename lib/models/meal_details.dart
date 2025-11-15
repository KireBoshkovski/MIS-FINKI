class MealDetails {
  final String idMeal;
  final String name;
  final String? alternateName;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String? tags;
  final String youtubeUrl;
  final String? source;
  final String? imageSource;
  final String? creativeCommonsConfirmed;
  final String? dateModified;

  final List<String> ingredients;
  final List<String> measures;

  MealDetails({
    required this.idMeal,
    required this.name,
    required this.alternateName,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.tags,
    required this.youtubeUrl,
    required this.source,
    required this.imageSource,
    required this.creativeCommonsConfirmed,
    required this.dateModified,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetails.fromJson(Map<String, dynamic> json) {
    // Parse ingredients & measures 1–20
    List<String> ingredientsList = [];
    List<String> measuresList = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json["strIngredient$i"];
      final measure = json["strMeasure$i"];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredientsList.add(ingredient.toString().trim());
      }

      if (measure != null && measure.toString().trim().isNotEmpty) {
        measuresList.add(measure.toString().trim());
      }
    }

    return MealDetails(
      idMeal: json["idMeal"],
      name: json["strMeal"],
      alternateName: json["strMealAlternate"],
      category: json["strCategory"],
      area: json["strArea"],
      instructions: json["strInstructions"],
      thumbnail: json["strMealThumb"],
      tags: json["strTags"],
      youtubeUrl: json["strYoutube"],
      source: json["strSource"],
      imageSource: json["strImageSource"],
      creativeCommonsConfirmed: json["strCreativeCommonsConfirmed"],
      dateModified: json["dateModified"],
      ingredients: ingredientsList,
      measures: measuresList,
    );
  }
}
