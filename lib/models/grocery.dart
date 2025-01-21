import 'package:flutter_shopping_list_app/models/category.dart';

class Grocery {
  Grocery({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  final String id;
  final String name;
  final int quantity;
  final Category category;
}
