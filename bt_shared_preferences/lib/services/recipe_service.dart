import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe.dart';

class RecipeService {
  static const String _recipesKey = 'recipes';
  static const String _bookmarksKey = 'bookmarks';
  static const String _groceryItemsKey = 'groceryItems';

  // Dữ liệu mẫu
  final List<Recipe> _sampleRecipes = [
    Recipe(
      id: '1',
      name: 'Spaghetti with Tomato Sauce',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1664472682525-0c0b50534850?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ingredients: ['Spaghetti', 'Tomatoes', 'Garlic', 'Olive oil', 'Basil'],
      calories: 450,
    ),
    Recipe(
      id: '2',
      name: 'Greek Salad',
      imageUrl:
          'https://images.unsplash.com/photo-1606735584785-1848fdcaea57?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ingredients: [
        'Cucumber',
        'Tomatoes',
        'Olives',
        'Feta cheese',
        'Olive oil'
      ],
      calories: 320,
    ),
    Recipe(
      id: '3',
      name: 'Chicken Sandwich',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1664472757995-3260cd26e477?q=80&w=1961&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ingredients: ['Bread', 'Chicken', 'Lettuce', 'Mayonnaise'],
      calories: 380,
    ),
  ];
  
  RecipeService() {
    _initSampleData();
  }

  Future<void> _initSampleData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_recipesKey)) {
      final recipesJson =
          // Chuyển đổi dữ liệu mẫu thành dạng JSON
          _sampleRecipes.map((r) => jsonEncode(r.toJson())).toList();
      await prefs.setStringList(_recipesKey, recipesJson);
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    // Tìm kiếm trong dữ liệu mẫu
    return _sampleRecipes
        .where(
            (recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Recipe>> getBookmarkedRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];
    return bookmarksJson
        .map((json) => Recipe.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> addBookmark(Recipe recipe) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarkedRecipes();

    if (!bookmarks.any((r) => r.id == recipe.id)) {
      bookmarks.add(recipe);
      final bookmarksJson =
          bookmarks.map((r) => jsonEncode(r.toJson())).toList();
      await prefs.setStringList(_bookmarksKey, bookmarksJson);

      // Add ingredients to grocery list
      final groceryItems = await getGroceryItems();
      final updatedGroceryItems = [...groceryItems];

      // Add new ingredients with recipe name as prefix
      for (var ingredient in recipe.ingredients) {
        final groceryItem = '${recipe.name}: $ingredient';
        if (!updatedGroceryItems.contains(groceryItem)) {
          updatedGroceryItems.add(groceryItem);
        }
      }

      await prefs.setStringList(_groceryItemsKey, updatedGroceryItems);
    }
  }

  Future<void> removeBookmark(Recipe recipe) async {
    final prefs = await SharedPreferences.getInstance();

    // Get and update bookmarks
    final bookmarks = await getBookmarkedRecipes();
    bookmarks.removeWhere((r) => r.id == recipe.id);
    final bookmarksJson = bookmarks.map((r) => jsonEncode(r.toJson())).toList();
    await prefs.setStringList(_bookmarksKey, bookmarksJson);

    // Get current grocery items
    final groceryItems = await getGroceryItems();

    // Remove ingredients that belong to this recipe
    final updatedGroceryItems = groceryItems
        .where((item) => !item.startsWith('${recipe.name}:'))
        .toList();

    // Save the updated grocery list
    await prefs.setStringList(_groceryItemsKey, updatedGroceryItems);
  }

  Future<List<String>> getGroceryItems() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_groceryItemsKey) ?? [];
  }

  Future<void> removeGroceryItem(String item) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getGroceryItems();
    items.remove(item);
    await prefs.setStringList(_groceryItemsKey, items);
  }
}
