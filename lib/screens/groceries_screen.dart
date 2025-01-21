import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/widgets/groceries/groceries_list.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: const GroceriesList(),
      ),
    );
  }
}
