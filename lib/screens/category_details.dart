import 'package:flutter/material.dart';
import 'package:helloworld/models/category.dart';
import 'package:helloworld/models/meal.dart';
import 'package:helloworld/services/service.dart';
import 'package:helloworld/widgets/meal_card.dart';
import 'package:helloworld/screens/meal_details_screen.dart';
import 'package:helloworld/widgets/search_widget.dart';

class CategoryDetails extends StatefulWidget {
  final Category category;

  const CategoryDetails({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final Service _service = Service();
  bool _isLoading = true;
  List<Meal> _meals = [];
  List<Meal> _filteredMeals = [];

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  void _loadMeals() async {
    final meals = await _service.loadMealsForCategory(widget.category.name);
    setState(() {
      _meals = meals;
      _filteredMeals = meals;
      _isLoading = false;
    });
  }

  void _onSearchResults(List<Meal> results) {
    setState(() {
      if (results.isEmpty) {
        _filteredMeals = _meals; // fallback to category meals
      } else {
        _filteredMeals = results;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.category.imageURL,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.category.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Meals",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SearchBarWidget<Meal>(
                    onSearch: (query) => _service.searchMeals(query),
                    onResults: _onSearchResults,
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.all(12),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredMeals.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final meal = _filteredMeals[index];
                      return InkWell(
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MealDetailsScreen(mealId: meal.id),
                                ),
                              ),
                          child: MealCard(
                            meal: meal,
                          ));
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
