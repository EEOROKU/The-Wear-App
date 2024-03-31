import 'dart:io';

import 'package:closet_app/locator.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:closet_app/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/model/cloth_item.dart';


class ClothingDetailsScreen extends StatefulWidget {
  final File imageFile;

  const ClothingDetailsScreen({super.key, required this.imageFile});

  @override
  _ClothingDetailsScreenState createState() => _ClothingDetailsScreenState();
}

class _ClothingDetailsScreenState extends State<ClothingDetailsScreen> {
  bool isSelected = true;
  String subcategory = '';
  String color = '';
  String material = '';
  String notes = '';
  String season = '';
  String occasion = '';

  List<String> seasons = ['Spring', 'Summer', 'Fall', 'Winter'];
  List<String> occasions = [
    'Work',
    'Casual',
    'Formal',
    'Party',
    'Outdoor',
    'Travel',
    'Sports',
    'Date',
    'Gym',
    'Wedding',
    'Other'
  ];
  Future<void> saveClothingItem(BuildContext context) async {
    try {
      if (selectedCategory.isEmpty) {
        // Show a pop-up message indicating that a category must be selected
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please select a category.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return; // Exit the method early
      }

      final String? imageUrl =
      await locator.get<UserController>().uploadclothPicture(selectedCategory, widget.imageFile);

      // Ensure that other values are saved as empty strings if not provided
      color ??= '';
      material ??= '';
      notes ??= '';
      season ??= '';
      occasion ??= '';

      // Create a ClothingItemModel instance with the provided details
      ClothingItemModel item = ClothingItemModel(
        imageUrl: imageUrl!,
        subcategory: selectedSubcategory,
        color: color,
        material: material,
        notes: notes,
        season: season,
        occasion: occasion,
      );

      // Use usercontroller to add the clothing item to the user's clothes map
      await locator.get<UserController>().saveClothingItem(item);

      // Show a pop-up message indicating success
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Item saved successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Navigate back to the homepage
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Handle error uploading image
      print('Error uploading item: $error');
    }
  }






  Iterable<String> categories = ClothingDictionary.categoryToSubcategories.keys;

  String selectedCategory = '';
  bool isSeasonExpanded = false;
  String selectedSeason = '';
  bool isCategoryVisible = false;
  bool isSubcategoryVisible = false;
  String selectedSubcategory = '';
  String selectedOccasion = '';
  bool  isOccasionVisible = false;



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
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: isSelected
                            ? Image.file(
                          widget.imageFile,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                            : Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Text(
                              'Image with background removed',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8.0,
                        right: 8.0,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isSelected = !isSelected;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust button padding
                            textStyle: const TextStyle(fontSize: 12.0), // Adjust button text size
                          ),
                          child: Text('Original image: ${isSelected ? "ON" : "OFF"}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'When will you wear it?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Season',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSeasonExpanded = !isSeasonExpanded;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        selectedSeason.isEmpty ? 'Show Seasons' : selectedSeason,
                        style: TextStyle(
                          color: selectedSeason.isEmpty ? Colors.blue : Colors.black,
                          decoration: selectedSeason.isEmpty ? TextDecoration.underline : null,
                        ),
                      ),
                      Icon(
                        isSeasonExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: selectedSeason.isEmpty ? Colors.blue : Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Visibility(
              visible: isSeasonExpanded,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedSeason = 'Spring';
                      });
                    },
                    child: const Text('Spring'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedSeason = 'Summer';
                      });
                    },
                    child: const Text('Summer'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedSeason = 'Fall';
                      });
                    },
                    child: const Text('Fall'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedSeason = 'Winter';
                      });
                    },
                    child: const Text('Winter'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Occasion',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isOccasionVisible = !isOccasionVisible;
                    });
                  },
                  child: Row(
                    children: [
                      Text(selectedOccasion.isEmpty ? 'Choose occasion' : selectedOccasion),
                      Icon(isOccasionVisible ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isOccasionVisible,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: occasions.map((occasion) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedOccasion = occasion;
                        isOccasionVisible = false; // Hide occasions after selection
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                        return selectedOccasion == occasion ? Colors.blue : Colors.grey[300]!;
                      }),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(8.0)),
                    ),
                    child: Text(occasion),
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCategoryVisible = !isCategoryVisible;
                      // Hide subcategory section when the category section is closed
                      if (!isCategoryVisible) {
                        isSubcategoryVisible = false;
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Text(selectedCategory.isEmpty ? 'Choose category' : selectedCategory),
                      Icon(isCategoryVisible ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isCategoryVisible,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: categories.map((category) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = category;
                        // Show subcategories when a category is selected
                        isSubcategoryVisible = true;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                        return selectedCategory == category && isSubcategoryVisible ? Colors.blue : Colors.grey[300]!;
                      }),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(8.0)),
                    ),
                    child: Text(category),
                  );
                }).toList(),
              ),
            ),
            CustomDropdown(
              options: ClothingDictionary.getSubcategories(selectedCategory) ?? [],
              selectedOption: selectedSubcategory,
              onChanged: (value) {
                setState(() {
                  selectedSubcategory = value;
                });
              },
              showButtons: isSubcategoryVisible, // Set to true or false based on your logic
            ),

            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(labelText: 'color'),
              onChanged: (value) => color = value,
            ),
            const SizedBox(height: 20.0),

            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Material'),
              onChanged: (value) => material = value,
            ),
            const SizedBox(height: 20.0),

            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Notes'),
              onChanged: (value) => notes = value,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => saveClothingItem(context),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

