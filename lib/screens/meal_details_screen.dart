import 'package:flutter/material.dart';
import 'package:helloworld/models/meal_details.dart';
import 'package:helloworld/services/service.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailsScreen extends StatefulWidget {
  final int mealId;

  const MealDetailsScreen({super.key, required this.mealId});

  @override
  State<StatefulWidget> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  final Service _service = Service();
  MealDetails? _meal;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadMealInfo();
  }

  Future<void> _loadMealInfo() async {
    try {
      final mealData = await _service.loadMealDetailsById(widget.mealId);
      setState(() {
        _meal = mealData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _openYoutube(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError || _meal == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Failed to load meal details.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final meal = _meal!;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.thumbnail,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                meal.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                "${meal.area} • ${meal.category}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Ingredients",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(meal.ingredients.length, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Card(
                  elevation: 2,
                  shadowColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.grey.shade50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.green,
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "${meal.ingredients[index]} - ${meal.measures[index]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Instructions",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                meal.instructions,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            if (meal.youtubeUrl.isNotEmpty)
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => _openYoutube(meal.youtubeUrl),
                  icon: const Icon(Icons.play_circle),
                  label: const Text("Watch on YouTube"),
                ),
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
