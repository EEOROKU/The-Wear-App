import 'package:closet_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/model/cloth_item.dart';
import 'package:closet_app/view_controller/backend_service.dart';

class ClothesScreen extends StatefulWidget {
  @override
  _ClothesScreenState createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  final BackendService _backendService = locator.get<BackendService>();
  List<ClothingItemModel> _clothes = [];
  String? _selectedCategory;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButton<String>(
            value: _selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                if (newValue == "All Clothes") {
                  _selectedCategory = null;
                  _loadData();
                } else {
                  _selectedCategory = newValue;
                  _loadClothesByCategory(_selectedCategory!);
                }
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: "All Clothes",
                child: Text("All Clothes"),
              ),
              ...ClothingDictionary.categoryToSubcategories.keys
                  .map<DropdownMenuItem<String>>(
                    (String category) =>
                    DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    ),
              )
                  .toList(),
            ],
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_clothes.isEmpty) {
      return Center(
        child: Text(
          _selectedCategory != null
              ? "You currently have no items in $_selectedCategory's"
              : "You currently have no items",
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _clothes.length,
        itemBuilder: (context, index) {
          final ClothingItemModel clothingItem = _clothes[index];
          return ListTile(
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
      );
    }
  }
}