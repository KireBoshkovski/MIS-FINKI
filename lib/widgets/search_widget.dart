import 'package:flutter/material.dart';

class SearchBarWidget<T> extends StatefulWidget {
  final Future<List<T>> Function(String query) onSearch;
  final void Function(List<T>) onResults;

  const SearchBarWidget(
      {super.key, required this.onSearch, required this.onResults});

  @override
  State<StatefulWidget> createState() => _SearchBarState<T>();
}

class _SearchBarState<T> extends State<SearchBarWidget<T>> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  void _handleSearch(String query) async {
    setState(() => _isSearching = true);

    try {
      final results = await widget.onSearch(query);
      widget.onResults(results);
    } catch (e) {
      widget.onResults([]);
    } finally {
      setState(() => _isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _isSearching
                ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
            border: const OutlineInputBorder(),
          ),
          onChanged: _handleSearch,
        ));
  }
}
