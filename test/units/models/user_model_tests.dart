import 'package:closet_app/model/cloth_item.dart';
import 'package:closet_app/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel tests', () {

    test('toMap converts UserModel to Map correctly', () {
      final userModel = UserModel(
        '12345',
        userEmail: 'test@example.com',
        userName: 'Test User',
        avatarUrl: 'example.com/avatar.jpg',
        clothes: {
          'Tops': [
            ClothingItemModel(
              subcategory: 'tshirts',
              imageUrl: 'example.com/image1.jpg',
            ),
            ClothingItemModel(
              subcategory: 'sweaters',
              imageUrl: 'example.com/image2.jpg',
            ),
          ],
          'Pants': [
            ClothingItemModel(
              subcategory: 'jeans',
              imageUrl: 'example.com/image3.jpg',
            ),
          ],
        },
      );

      final map = userModel.toMap();

      expect(map['uid'], equals('12345'));
      expect(map['userEmail'], equals('test@example.com'));
      expect(map['userName'], equals('Test User'));
      expect(map['avatarUrl'], equals('example.com/avatar.jpg'));

      expect(map['clothes'].length, equals(2)); // Assuming the model contains items for Tops and Pants
      expect(map['clothes']['Tops']!.length, equals(2)); // Assuming 2 items for Tops
      expect(map['clothes']['Pants']!.length, equals(1)); // Assuming 1 item for Pants
    });

    test('getParentCategory returns correct parent category', () {
      final item = ClothingItemModel(
        subcategory: 'tshirts',
        imageUrl: 'example.com/image.jpg',
      );
      final userModel = UserModel('12345');

      expect(userModel.getParentCategory(item), equals('Tops'));
    });
  });
}

