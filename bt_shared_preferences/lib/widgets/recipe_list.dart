import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import 'custom_dropdown.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  static const String prefSearchKey = 'previousSearches';
  List<String> previousSearches = <String>[];
  final TextEditingController searchTextController = TextEditingController();
  List<Recipe> recipes = [];
  List<Recipe> bookmarkedRecipes = [];
  bool isLoading = false;
  final RecipeService _recipeService = RecipeService();

  @override
  void initState() {
    super.initState();
    getPreviousSearches();
    _loadInitialRecipes();
    _loadBookmarkedRecipes();
  }

  Future<void> _loadBookmarkedRecipes() async {
    final bookmarks = await _recipeService.getBookmarkedRecipes();
    setState(() {
      bookmarkedRecipes = bookmarks;
    });
  }

  Future<void> _loadInitialRecipes() async {
    setState(() {
      isLoading = true;
    });
    try {
      final results = await _recipeService.searchRecipes('');
      setState(() {
        recipes = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSearchKey)) {
      final searches = prefs.getStringList(prefSearchKey);
      if (searches != null) {
        setState(() {
          previousSearches = searches;
        });
      }
    }
  }

  void savePreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  Future<void> startSearch(String value) async {
    setState(() {
      isLoading = true;
      value = value.trim();

      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });

    try {
      final results = await _recipeService.searchRecipes(value);
      setState(() {
        recipes = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  bool isBookmarked(Recipe recipe) {
    return bookmarkedRecipes.any((r) => r.id == recipe.id);
  }

  Future<void> toggleBookmark(Recipe recipe) async {
    if (isBookmarked(recipe)) {
      await _recipeService.removeBookmark(recipe);
      setState(() {
        bookmarkedRecipes.removeWhere((r) => r.id == recipe.id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Removed from bookmarks'),
          ),
        );
      }
    } else {
      await _recipeService.addBookmark(recipe);
      setState(() {
        bookmarkedRecipes.add(recipe);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to bookmarks'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: Column(
        children: [
          _buildSearchCard(),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (recipes.isEmpty)
            const Center(
              child: Text('No recipes found'),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  final bool bookmarked = isBookmarked(recipe);
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.green,
                          width: double.infinity,
                          child: Text(
                            recipe.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: recipe.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ingredients:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                recipe.ingredients.join(', '),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Calories: ${recipe.calories}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () => toggleBookmark(recipe),
                                    icon: Icon(
                                      bookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: bookmarked ? Colors.white : null,
                                    ),
                                    label: Text(bookmarked
                                        ? 'Remove Bookmark'
                                        : 'Bookmark'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: bookmarked
                                          ? Colors.red
                                          : Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        startSearch(searchTextController.text);
                      },
                      controller: searchTextController,
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    onSelected: (String value) {
                      searchTextController.text = value;
                      startSearch(searchTextController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      return previousSearches
                          .map<CustomDropdownMenuItem<String>>((String value) {
                        return CustomDropdownMenuItem<String>(
                          text: value,
                          value: value,
                          callback: () {
                            setState(() {
                              previousSearches.remove(value);
                              savePreviousSearches();
                              Navigator.pop(context);
                            });
                          },
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
