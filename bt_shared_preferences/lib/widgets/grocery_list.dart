import 'package:flutter/material.dart';
import '../services/recipe_service.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<String> groceryItems = [];
  final RecipeService _recipeService = RecipeService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGroceryItems();
  }

  Future<void> _loadGroceryItems() async {
    setState(() {
      isLoading = true;
    });
    try {
      final items = await _recipeService.getGroceryItems();
      setState(() {
        groceryItems = items;
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

  Future<void> _removeItem(String item) async {
    try {
      await _recipeService.removeGroceryItem(item);
      setState(() {
        groceryItems.remove(item);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error removing item: $e')),
        );
      }
    }
  }

  Map<String, List<String>> _groupItemsByRecipe() {
    final groupedItems = <String, List<String>>{};

    for (var item in groceryItems) {
      final parts = item.split(': ');
      if (parts.length == 2) {
        final recipeName = parts[0];
        final ingredient = parts[1];
        groupedItems.putIfAbsent(recipeName, () => []).add(ingredient);
      }
    }

    return groupedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : groceryItems.isEmpty
              ? const Center(child: Text('No items in grocery list'))
              : ListView.builder(
                  itemCount: _groupItemsByRecipe().length,
                  itemBuilder: (context, index) {
                    final recipes = _groupItemsByRecipe().keys.toList();
                    final recipeName = recipes[index];
                    final ingredients = _groupItemsByRecipe()[recipeName]!;

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
                              recipeName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ingredients.length,
                            itemBuilder: (context, i) {
                              final ingredient = ingredients[i];
                              return Dismissible(
                                key: Key('$recipeName:$ingredient'),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20.0),
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  _removeItem('$recipeName: $ingredient');
                                },
                                child: ListTile(
                                  title: Text(ingredient),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _removeItem('$recipeName: $ingredient');
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
