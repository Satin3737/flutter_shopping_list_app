import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';
import 'package:flutter_shopping_list_app/widgets/groceries/add_grocery_item.dart';
import 'package:flutter_shopping_list_app/widgets/groceries/groceries_list.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  final List<Grocery> _groceries = [];

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
      body: GroceriesList(groceries: _groceries, onRemove: _removeGroceryItem),
    );
  }
}
