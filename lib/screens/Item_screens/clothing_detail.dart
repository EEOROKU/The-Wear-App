

import 'dart:io';

import 'package:flutter/material.dart';

class ClothingDetailsScreen extends StatefulWidget {
  final File imageFile; // Add imageFile property

  const ClothingDetailsScreen({super.key, required this.imageFile});

  @override
  _ClothingDetailsScreenState createState() => _ClothingDetailsScreenState();
}

class _ClothingDetailsScreenState extends State<ClothingDetailsScreen> {
  bool isSelected = false; // Track toggle state

  String category = '';
  String subcategory = '';
  String color = '';
  String material = '';
  String pattern = '';
  String brand = '';
  String notes = '';

  // Function to save clothing item
  void saveClothingItem() {
    // Implement logic to save clothing item to database
    // For example, you can use a data service class to interact with Firestore
    // Here's a basic example:
    // DatabaseService().saveClothingItem(category, subcategory, color, material, pattern, brand, notes);
    // You would replace DatabaseService() with your actual data service class
    // and define the saveClothingItem method accordingly.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Clothing Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected; // Toggle state
                  });
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.file( // Use Image.file to display the selected image
                        widget.imageFile,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      if (isSelected)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Selected',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Clothing Details',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Category'),
              onChanged: (value) => category = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Subcategory'),
              onChanged: (value) => subcategory = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Color'),
              onChanged: (value) => color = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Material'),
              onChanged: (value) => material = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Pattern'),
              onChanged: (value) => pattern = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Brand'),
              onChanged: (value) => brand = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Notes'),
              onChanged: (value) => notes = value,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: saveClothingItem, // Call saveClothingItem method when button is pressed
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
