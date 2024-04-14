import 'package:closet_app/model/cloth_item.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('ClothingDictionary tests', () {
    test('getSubcategories returns correct list for valid parent category', () {
      expect(ClothingDictionary.getSubcategories('Tops'), equals(['tshirts', 'lonsleeve tshirt', 'sleeveless tshirt', 'polo shirts', 'tanksand camis', 'ctoptops', 'blouses', 'shirt', 'sweatshirts', 'hoodies', 'sweaters', 'sweater vest', 'cardigan', 'sports tops', 'bodysuit']));
    });

    test('getSubcategories returns empty list for invalid parent category', () {
      expect(ClothingDictionary.getSubcategories('Invalid'), isEmpty);
    });

    test('getParentCategory returns correct parent category for valid subcategory', () {
      expect(ClothingDictionary.getParentCategory('tshirts'), equals('Tops'));
    });

    test('getParentCategory returns empty string for invalid subcategory', () {
      expect(ClothingDictionary.getParentCategory('Invalid'), isEmpty);
    });
  });

  group('ClothingItemModel tests', () {
    test('toMap converts ClothingItemModel to Map correctly', () {
      final clothingItem = ClothingItemModel(
        subcategory: 'tshirts',
        imageUrl: 'example.com/image.jpg',
        color: 'blue',
        material: 'cotton',
        notes: 'example notes',
        season: 'summer',
        occasion: 'casual',
      );

      expect(clothingItem.toMap(), equals({
        'subcategory': 'tshirts',
        'color': 'blue',
        'material': 'cotton',
        'imageUrl': 'example.com/image.jpg',
        'notes': 'example notes',
        'season': 'summer',
        'occasion': 'casual',
      }));
    });

    test('fromMap creates ClothingItemModel from Map correctly', () {
      final map = {
        'subcategory': 'tshirts',
        'color': 'blue',
        'material': 'cotton',
        'imageUrl': 'example.com/image.jpg',
        'notes': 'example notes',
        'season': 'summer',
        'occasion': 'casual',
      };

      final clothingItem = ClothingItemModel.fromMap(map);

      expect(clothingItem.subcategory, equals('tshirts'));
      expect(clothingItem.color, equals('blue'));
      expect(clothingItem.material, equals('cotton'));
      expect(clothingItem.imageUrl, equals('example.com/image.jpg'));
      expect(clothingItem.notes, equals('example notes'));
      expect(clothingItem.season, equals('summer'));
      expect(clothingItem.occasion, equals('casual'));
    });

    test('getParentCategory returns correct parent category', () {
      final clothingItem = ClothingItemModel(
        subcategory: 'tshirts',
        imageUrl: 'example.com/image.jpg',
      );

      expect(clothingItem.getParentCategory(), equals('Tops'));
    });

    test('getImageUrl returns correct image URL', () {
      final clothingItem = ClothingItemModel(
        subcategory: 'tshirts',
        imageUrl: 'example.com/image.jpg',
      );

      expect(clothingItem.getImageUrl(), equals('example.com/image.jpg'));
    });
  });
}
