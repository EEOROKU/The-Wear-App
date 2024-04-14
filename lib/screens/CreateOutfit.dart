import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../locator.dart';
import '../model/cloth_item.dart';
import '../model/user_model.dart';
import '../view_controller/backend_service.dart';
import '../view_controller/user_controller.dart';




class CreateOutfit extends StatefulWidget {
  @override
  _CreateOutfit createState() => _CreateOutfit();
}

class _CreateOutfit extends State<CreateOutfit>{

  String img = 'https://shorturl.at/fszJS';
  String img2 = 'https://shorturl.at/dkO15';
  String img3 = 'https://shorturl.at/hiQX3';

  void updateImage(String newImg) {
    setState(() {
      img = newImg;
    });
  }
  void updateImage2(String newImg) {
    setState(() {
      img2 = newImg;
    });
  }
  void updateImage3(String newImg) {
    setState(() {
      img3 = newImg;
    });
  }
  final BackendService _backendService = locator.get<BackendService>();
  List<ClothingItemModel> _clothes = [];
  String? _selectedCategory;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    List<ClothingItemModel> clothes = await _backendService.getAllClothes();
    setState(() {
      _clothes = clothes;
    });
  }

  Future<void> _loadClothesByCategory(String category) async {
    List<ClothingItemModel> clothes =
    await _backendService.getClothesByCategory(category);
    setState(() {
      _clothes = clothes;
    });
  }

  Future<void> getUserData() async {
    userModel = locator.get<UserController>().currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Create outfit',)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClothesPage(clothes: _clothes, selectedCategory: _selectedCategory, onImageSelect: updateImage),
                  ),
                );
              },
              child: Image.network(img),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClothesPage1(clothes: _clothes, selectedCategory: _selectedCategory, onImageSelect: updateImage2),
                  ),
                );
              },
              child: Image.network(img2),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClothesPage2(clothes: _clothes, selectedCategory: _selectedCategory, onImageSelect: updateImage3),
                  ),
                );
              },
              child: Image.network(img3),
            ),
          ],
        ),
      ),
    );
  }
}

class ClothesPage extends StatefulWidget {
  final List<ClothingItemModel> clothes;
  final String? selectedCategory;
  final ValueChanged<String> onImageSelect;

  ClothesPage({required this.clothes, this.selectedCategory, required this.onImageSelect});

  @override
  _ClothesPageState createState() => _ClothesPageState();
}

class _ClothesPageState extends State<ClothesPage> {

  @override
  Widget build(BuildContext context) {
    if (widget.clothes.isEmpty) {
      return Center(
        child: Text(
          widget.selectedCategory != null
              ? "You currently have no items in ${widget.selectedCategory}'s"
              : "You currently have no items",
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
      return Material( // Add this
        child: Scaffold(
          appBar: AppBar(title: Text('Pick a Tshirt'),),
          body: ListView.builder(
          itemCount: widget.clothes.length,
          itemBuilder: (context, index) {
            final ClothingItemModel clothingItem = widget.clothes[index];
            return ListTile(
              onTap: (){
                widget.onImageSelect(clothingItem.imageUrl);
              },
              title: Text(clothingItem.subcategory),
              subtitle: Text(clothingItem.occasion ?? ''),
              leading: Image.network(
                clothingItem.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            );
          },
        ),),

      ); // Add this
    }
  }
}

class ClothesPage1 extends StatefulWidget {
  final List<ClothingItemModel> clothes;
  final String? selectedCategory;
  final ValueChanged<String> onImageSelect;

  ClothesPage1({required this.clothes, this.selectedCategory, required this.onImageSelect});

  @override
  _ClothesPageState1 createState() => _ClothesPageState1();
}

class _ClothesPageState1 extends State<ClothesPage1> {

  @override
  Widget build(BuildContext context) {
    if (widget.clothes.isEmpty) {
      return Center(
        child: Text(
          widget.selectedCategory != null
              ? "You currently have no items in ${widget.selectedCategory}'s"
              : "You currently have no items",
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
      return Material( // Add this
        child: Scaffold(
          appBar: AppBar(title: Text('Pick a Tshirt'),),
          body: ListView.builder(
            itemCount: widget.clothes.length,
            itemBuilder: (context, index) {
              final ClothingItemModel clothingItem = widget.clothes[index];
              return ListTile(
                onTap: (){
                  widget.onImageSelect(clothingItem.imageUrl);
                },
                title: Text(clothingItem.subcategory),
                subtitle: Text(clothingItem.occasion ?? ''),
                leading: Image.network(
                  clothingItem.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),),

      ); // Add this
    }
  }
}

class ClothesPage2 extends StatefulWidget {
  final List<ClothingItemModel> clothes;
  final String? selectedCategory;
  final ValueChanged<String> onImageSelect;

  ClothesPage2({required this.clothes, this.selectedCategory, required this.onImageSelect});

  @override
  _ClothesPageState2 createState() => _ClothesPageState2();
}

class _ClothesPageState2 extends State<ClothesPage2> {

  @override
  Widget build(BuildContext context) {
    if (widget.clothes.isEmpty) {
      return Center(
        child: Text(
          widget.selectedCategory != null
              ? "You currently have no items in ${widget.selectedCategory}'s"
              : "You currently have no items",
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
      return Material( // Add this
        child: Scaffold(
          appBar: AppBar(title: Text('Pick a Tshirt'),),
          body: ListView.builder(
            itemCount: widget.clothes.length,
            itemBuilder: (context, index) {
              final ClothingItemModel clothingItem = widget.clothes[index];
              return ListTile(
                onTap: (){
                  widget.onImageSelect(clothingItem.imageUrl);
                },
                title: Text(clothingItem.subcategory),
                subtitle: Text(clothingItem.occasion ?? ''),
                leading: Image.network(
                  clothingItem.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),),

      ); // Add this
    }
  }
}
