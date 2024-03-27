import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'clothing_detail.dart'; // Import the ClothingDetailsScreen

class AddClothesPage extends StatefulWidget {
  const AddClothesPage({super.key});

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

        _uploadImageToStorage(_imageFile!);
      } else {
        print('No image selected.');
      }
    });
  }
  Future<void> _uploadImageToStorage(File imageFile) async {
    try {
      // Create a reference to the image file in Firebase Storage
      Reference ref = _storage.ref().child('clothing_images/${DateTime.now().toString()}');

      // Upload file to Firebase Storage
      UploadTask uploadTask = ref.putFile(imageFile);

      // Get download URL of uploaded image
      String imageUrl = await (await uploadTask).ref.getDownloadURL();

      // Navigate to ClothingDetailsScreen with image URL
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClothingDetailsScreen( imageFile:imageFile,),
        ),
      );
    } catch (e) {
      print('Error uploading image: $e');
    }
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
                ? Image.file(
              _imageFile!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(const MaterialApp(
    home: AddClothesPage(),
  ));
}
