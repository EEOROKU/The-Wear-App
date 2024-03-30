import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'clothing_detail.dart';
class AddClothesPage extends StatefulWidget {
  const AddClothesPage({super.key});

  @override
  _AddClothesPageState createState() => _AddClothesPageState();
}

class _AddClothesPageState extends State<AddClothesPage> {
  var _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Clothes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Clothes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.gallery),
              child: const Text('Add Clothes from Gallery'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.camera),
              child: const Text('Take a Picture'),
            ),
            const SizedBox(height: 20),
            _imageFile != null
                ? Column(
              children: [
                Image.file(
                  _imageFile!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ClothingDetailsScreen(imageFile: _imageFile!),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ],
            )
                : const SizedBox(),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}