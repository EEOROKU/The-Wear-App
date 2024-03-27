import 'package:closet_app/helper/helper_function.dart';
import 'package:closet_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
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

    // Save user data using your HelperFunctions or perform any other operations
    await HelperFunctions.saveUserLoggedInStatus(true);
    await HelperFunctions.saveUserEmailSF(userEmail);
    await HelperFunctions.saveUserNameSF(userName);

    // Return the user data
    return UserModel(uid, userEmail: userEmail, userName: userName, avatarUrl: avatarUrl);
  }



}
