import 'package:flutter/material.dart';

class OutfitScreen extends StatelessWidget {
  const OutfitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Outfit Screen',
          style: TextStyle(fontSize: 24), // Example text style
        ),
        SizedBox(height: 20), // Optional: Add spacing between the text and other widgets
        Column(
          children: [
            Text(
              'Closet',
              style: TextStyle(fontSize: 18), // Example text style
            ),
            Row(
              children: <Widget>[
                Icon(Icons.filter_list),
                SizedBox(width: 10), // Optional: to give some spacing
                Expanded(
                  // Use Expanded to make sure TextField takes the remaining space
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Search",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
