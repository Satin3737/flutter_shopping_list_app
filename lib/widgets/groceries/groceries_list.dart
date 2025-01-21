import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/data/dummy_groceries.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: groceries.length,
      itemBuilder: (ctx, index) => ListTile(
        minLeadingWidth: 24,
        horizontalTitleGap: 24,
        minVerticalPadding: 0,
        minTileHeight: 0,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 16,
        ),
        leading: Container(
          width: 24,
          height: 24,
          color: groceries[index].category.color,
        ),
        title: Text(groceries[index].name),
        trailing: Text(groceries[index].quantity.toString()),
      ),
    );
  }
}
