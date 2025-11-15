class Category {
  int id;
  String name;
  String imageURL;
  String description;

  Category(
      {required this.id,
      required this.name,
      required this.imageURL,
      required this.description});

  Category.fromJson(Map<String, dynamic> data)
      : id = int.parse(data['idCategory']),
        name = data['strCategory'] ?? '',
        imageURL = data['strCategoryThumb'] ?? '',
        description = data['strCategoryDescription'] ?? '';
}
