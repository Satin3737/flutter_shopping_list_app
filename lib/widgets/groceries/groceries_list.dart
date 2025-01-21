import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({
    super.key,
    required this.groceries,
    required this.onRemove,
  });

  final List<Grocery> groceries;
  final void Function(Grocery, int) onRemove;

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - appBarHeight;

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      crossFadeState: groceries.isEmpty
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: SizedBox(
        height: availableHeight,
        child: const Center(
          child: Text(
            'No groceries added yet!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      secondChild: SizedBox(
        height: availableHeight,
        child: ListView.builder(
          itemCount: groceries.length,
          itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(groceries[index]),
            onDismissed: (_) => onRemove(groceries[index], index),
            background: Container(
              color: Colors.redAccent,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              child: const Icon(Icons.delete, size: 32),
            ),
            child: ListTile(
              minLeadingWidth: 24,
              horizontalTitleGap: 24,
              minVerticalPadding: 0,
              minTileHeight: 0,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
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
          ),
        ),
      ),
    );
  }
}
