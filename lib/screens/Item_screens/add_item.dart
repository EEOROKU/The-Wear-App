import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'clothing_detail.dart'; // Import the ClothingDetailsScreen

class AddClothesPage extends StatefulWidget {
  const AddClothesPage({Key? key}) : super(key: key);

  @override
  _AddClothesPageState createState() => _AddClothesPageState();
}

class _AddClothesPageState extends State<AddClothesPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance; // Create FirebaseStorage instance

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
                  onPressed: () =>    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClothingDetailsScreen(imageFile: _imageFile!),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ],
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
