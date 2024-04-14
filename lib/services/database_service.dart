
import 'package:closet_app/helper/helper_function.dart';
import 'package:closet_app/model/cloth_item.dart';
import 'package:closet_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");


  // saving the userdata
  Future savingUserData(String userName, String userEmail, String? avatarUrl) async {
    UserModel user = UserModel(uid!, userEmail: userEmail, userName: userName,avatarUrl: avatarUrl);

    await HelperFunctions.saveUserLoggedInStatus(true);
    await HelperFunctions.saveUserEmailSF(userEmail);
    await HelperFunctions.saveUserNameSF(userName);
    return await userCollection.doc(uid).set({
      "userName": userName,
      "userEmail": userEmail,
      "model": user.toMap(),

    });
  }

  ///update this to update the user avatarurl
  Future<void> uploadAvatarUrl(String avatarUrl) async {
    final userData = await gettingUserData(uid!); // Get user data from Firestore
    String? userName = userData.userName;
    String? userEmail = userData.userEmail;
    await savingUserData(userName!, userEmail!, avatarUrl);
  }

  Future<UserModel> gettingUserData(String uid) async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();

    // Retrieve the user data from the document
    String userName = snapshot['userName'];
    String userEmail = snapshot['userEmail'];
    String? avatarUrl = snapshot['model']["avatarUrl"]; // Make sure to handle null for avatarUrl
    print("yyyy");
    // Convert dynamic map to Map<String, List<ClothingItemModel>>
    Map<String, dynamic>? clothesMap = snapshot['model']['clothes'];
    Map<String, List<ClothingItemModel>> convertedClothesMap = {};
    if (clothesMap != null) {
      clothesMap.forEach((key, value) {
        List<dynamic> itemList = value as List<dynamic>;
        List<ClothingItemModel> clothingItemList = itemList.map((item) => ClothingItemModel.fromMap(item)).toList();
        convertedClothesMap[key] = clothingItemList;
      });
    }



    // Save user data using your HelperFunctions or perform any other operations
    await HelperFunctions.saveUserLoggedInStatus(true);
    await HelperFunctions.saveUserEmailSF(userEmail);
    await HelperFunctions.saveUserNameSF(userName);

    // Return the user data
    return UserModel(uid, userEmail: userEmail, userName: userName, avatarUrl: avatarUrl,clothes: convertedClothesMap);
  }


// Method to add a clothing item to the user's clothes map
  Future<void> addClothingItem(ClothingItemModel clothingItem) async {
    String parentCategory = clothingItem.getParentCategory();

    // Get the user document
    DocumentSnapshot userSnapshot = await userCollection.doc(uid).get();

    // Check if the user document exists
    if (userSnapshot.exists) {
      // Extract the 'model' data from the user snapshot
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> modelData = userData['model'] as Map<String, dynamic>;

      // Initialize an empty 'clothes' map if it doesn't exist
      Map<String, dynamic> clothesMap = modelData['clothes'] as Map<String, dynamic>? ?? {};


      // Retrieve or initialize the list of clothing items for the parent category
      List<ClothingItemModel> categoryItems =
          (clothesMap[parentCategory] as List<dynamic>?)?.map((item) => ClothingItemModel.fromMap(item)).toList() ?? [];

      // Add the new clothing item to the list
      categoryItems.add(clothingItem);

      // Update the 'clothesMap' with the modified list
      clothesMap[parentCategory] = categoryItems.map((item) => item.toMap()).toList();

      // Update the 'model' field in the user document
      await userCollection.doc(uid).update({
        'model': {
          ...modelData, // Keep existing 'model' data
          'clothes': clothesMap, // Update 'clothes' with the new map
        }
      });
    }
  }


  Future<List<ClothingItemModel>> getClothesByParentCategory(String parentCategory) async {
    // Get the user document
    DocumentSnapshot userSnapshot = await userCollection.doc(uid).get();

    // Check if the user document exists
    if (userSnapshot.exists) {
      // Get the user data
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

      // Retrieve the 'clothes' map from the user data
      Map<String, dynamic>? clothesMap = userData['model']['clothes'] as Map<String, dynamic>?;

      // Check if the clothes map exists and contains the specified parent category
      if (clothesMap != null && clothesMap.containsKey(parentCategory)) {
        // Extract the list of cloth items corresponding to the parent category
        List<dynamic> items = clothesMap[parentCategory];

        // Convert the dynamic items to ClothingItemModel objects
        List<ClothingItemModel> clothingItems = items
            .map((itemData) => ClothingItemModel.fromMap(itemData))
            .toList();

        return clothingItems;
      }
    }

    // Return an empty list if no items are found or an error occurs
    return [];
  }


  Future updateUserName(String uid,String userName) async {
    await HelperFunctions.saveUserNameSF(userName);
    return await userCollection.doc(uid).set({
      "userName": userName,
    });


  }}
