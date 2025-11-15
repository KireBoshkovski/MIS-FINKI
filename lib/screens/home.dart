import 'package:flutter/material.dart';
import 'package:helloworld/models/category.dart';
import 'package:helloworld/screens/category_details.dart';
import 'package:helloworld/screens/meal_details_screen.dart';
import 'package:helloworld/widgets/category_card.dart';

import '../services/service.dart';
import '../widgets/search_widget.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Service _service = Service();
  late List<Category> _filteredCategories;
  bool _isLoading = true;

  void _openRandomMeal() async {
    try {
      final randomMeal = await Service().loadRandomMeal();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MealDetailsScreen(mealId: int.parse(randomMeal.idMeal)),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load random meal")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Categories"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle_rounded),
            tooltip: "Random Recipe",
            onPressed: _openRandomMeal,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SearchBarWidget<Category>(
                  onSearch: (query) async => (await _service.loadCategories())
                      .where((c) =>
                          c.name.toLowerCase().contains(query.toLowerCase()))
                      .toList(),
                  onResults: (results) {
                    setState(() => _filteredCategories = results);
                  },
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: _filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = _filteredCategories[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryDetails(category: category),
                        ),
                      ),
                      child: CategoryCard(
                        category: category,
                      ),
                    );
                  },
                ))
              ],
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCategoriesList();
  }

  void _loadCategoriesList() async {
    final categoryList = await _service.loadCategories();

    setState(() {
      _filteredCategories = categoryList;
      _isLoading = false;
    });
  }
}
