import 'package:flutter_shopping_list_app/data/dummy_categories.dart';
import 'package:flutter_shopping_list_app/models/category.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';

final groceries = [
  Grocery(
    id: 'a',
    name: 'Milk',
    quantity: 1,
    category: categories[Categories.dairy]!,
  ),
  Grocery(
    id: 'b',
    name: 'Bananas',
    quantity: 5,
    category: categories[Categories.fruit]!,
  ),
  Grocery(
    id: 'c',
    name: 'Beef Steak',
    quantity: 1,
    category: categories[Categories.meat]!,
  ),
];
