class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> ingredients;
  final int calories;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ingredients,
    required this.calories,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'calories': calories,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      ingredients: List<String>.from(json['ingredients']),
      calories: json['calories'],
    );
  }
}
