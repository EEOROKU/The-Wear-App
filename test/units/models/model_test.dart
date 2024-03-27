// // Import your UserModel class
//
// import 'package:closet_app/model/model.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// void main() {
//   group('UserModel Tests', () {
//     test('UserModel fromMap should correctly parse map to UserModel object', () {
//       // Arrange
//       final map = {
//         'uid': 'user123',
//         'email': 'test@example.com',
//         'userName': 'test_user',
//       };
//
//       // Act
//       final userModel = UserModel.fromMap(map);
//
//       // Assert
//       expect(userModel.uid, 'user123');
//       expect(userModel.userEmail, 'test@example.com');
//       expect(userModel.userName, 'test_user');
//     });
//
//     test('UserModel toMap should correctly convert UserModel object to map', () {
//       // Arrange
//       final userModel = UserModel(
//         uid: 'user123',
//         userEmail: 'test@example.com',
//         userName: 'test_user',
//       );
//
//       // Act
//       final map = userModel.toMap();
//
//       // Assert
//       expect(map['uid'], 'user123');
//       expect(map['email'], 'test@example.com');
//       expect(map['userName'], 'test_user');
//     });
//   });
// }
