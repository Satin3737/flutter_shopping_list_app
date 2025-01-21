import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/data/dummy_categories.dart';
import 'package:flutter_shopping_list_app/models/category.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';

class AddGroceryItem extends StatefulWidget {
  const AddGroceryItem({super.key});

  @override
  State<AddGroceryItem> createState() => _NewGroceryItemState();
}

class _NewGroceryItemState extends State<AddGroceryItem> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, Object?> _formValues = {
    'name': '',
    'quantity': '1',
    'category': null,
  };

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        Grocery(
          id: DateTime.now().toString(),
          name: _formValues['name'] as String,
          quantity: int.parse(_formValues['quantity'] as String),
          category: _formValues['category'] as Category,
        ),
      );
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
                onSaved: (value) => _formValues['name'] = value,
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
                      onSaved: (value) => _formValues['quantity'] = value,
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(labelText: 'Category'),
                      validator: (value) {
                        if (value == null) {
                          return 'Category is required';
                        }
                        return null;
                      },
                      onSaved: (value) => _formValues['category'] = value,
                      onChanged: (value) => _formValues['category'] = value,
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
                      onPressed: _resetForm,
                      child: const Text('Reset'),
                    ),
                    FilledButton(
                      onPressed: _saveForm,
                      child: const Text('Save'),
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
