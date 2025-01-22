import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/const.dart';
import 'package:flutter_shopping_list_app/data/dummy_categories.dart';
import 'package:flutter_shopping_list_app/models/category.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';
import 'package:http/http.dart' as http;

class AddGroceryItem extends StatefulWidget {
  const AddGroceryItem({super.key});

  @override
  State<AddGroceryItem> createState() => _AddGroceryItemState();
}

class _AddGroceryItemState extends State<AddGroceryItem> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _name = '';
  int _quantity = 1;
  Category _category = categories[Categories.other]!;

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isLoading = true);

      final response = await http.post(
        Uri.https(apiBaseUrl, 'shopping-list.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _name,
          'quantity': _quantity,
          'category': _category.title,
        }),
      );

      if (context.mounted) {
        Navigator.of(context).pop(
          Grocery(
            id: jsonDecode(response.body)['name'],
            name: _name,
            quantity: _quantity,
            category: _category,
          ),
        );
      }
    }
  }

  void _resetForm() => _formKey.currentState!.reset();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Grocery Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 8,
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters long';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      initialValue: '1',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Quantity is required';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Quantity must be a number';
                        }
                        if (int.tryParse(value) == 0) {
                          return 'Quantity must be greater than 0';
                        }
                        return null;
                      },
                      onSaved: (value) => _quantity = int.parse(value!),
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _category,
                      decoration: const InputDecoration(labelText: 'Category'),
                      validator: (value) {
                        if (value == null) {
                          return 'Category is required';
                        }
                        return null;
                      },
                      onSaved: (value) => _category = value!,
                      onChanged: (value) => _category = value!,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              spacing: 8,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isLoading ? null : _resetForm,
                      child: const Text('Reset'),
                    ),
                    FilledButton(
                      onPressed: _isLoading ? null : _saveForm,
                      child: _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Text('Save'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
