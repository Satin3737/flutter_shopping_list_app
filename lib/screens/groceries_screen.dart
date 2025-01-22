import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/const.dart';
import 'package:flutter_shopping_list_app/data/dummy_categories.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';
import 'package:flutter_shopping_list_app/widgets/groceries/add_grocery_item.dart';
import 'package:flutter_shopping_list_app/widgets/groceries/groceries_list.dart';
import 'package:http/http.dart' as http;

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  List<Grocery> _groceries = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchGroceries();
  }

  _fetchGroceries() async {
    setState(() => _isLoading = true);
    final response = await http.get(
      Uri.https(apiBaseUrl, 'shopping-list.json'),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> list = jsonDecode(response.body);

    setState(() {
      _groceries = list.entries
          .map((entry) => Grocery(
              id: entry.key,
              name: entry.value['name'],
              quantity: entry.value['quantity'],
              category: categories.entries
                  .firstWhere(
                    (cat) => cat.value.title == entry.value['category'],
                  )
                  .value))
          .toList();
    });
    _isLoading = false;
  }

  void _addNewGroceryItem() async {
    final newItem = await Navigator.of(context).push<Grocery>(
      MaterialPageRoute(builder: (context) => const AddGroceryItem()),
    );
    if (newItem != null) setState(() => _groceries.add(newItem));
  }

  void _removeGroceryItem(Grocery grocery, int index) {
    setState(() => _groceries.remove(grocery));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${grocery.name} removed from your groceries'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(
            () => _groceries.insert(index, grocery),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewGroceryItem,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GroceriesList(groceries: _groceries, onRemove: _removeGroceryItem),
    );
  }
}
