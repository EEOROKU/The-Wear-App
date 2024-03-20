import 'package:closet_app/helper/helper_function.dart';
import 'package:closet_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");


  // saving the userdata
  Future savingUserData(String userName, String userEmail) async {
    UserModel user = UserModel(uid: uid, userEmail: userEmail, userName: userName);

    await HelperFunctions.saveUserLoggedInStatus(true);
    await HelperFunctions.saveUserEmailSF(userEmail);
    await HelperFunctions.saveUserNameSF(userName);
    return await userCollection.doc(uid).set({
      "userName": userName,
      "userEmail": userEmail,
      "model": user.toMap(),
      "profilePic": "",
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where("userEmail", isEqualTo: email).get();

    if (snapshot.docs.isEmpty) {
      // Handle case where no user with the specified email is found
      return null;
    }

    // Loop through each document in the query snapshot
    for (DocumentSnapshot doc in snapshot.docs) {
      // Retrieve the user data from each document
      String userName = doc['userName'];
      String userEmail = doc['userEmail'];

      // Save user data using your HelperFunctions or perform any other operations
      await HelperFunctions.saveUserLoggedInStatus(true);
      await HelperFunctions.saveUserEmailSF(userEmail);
      await HelperFunctions.saveUserNameSF(userName);
    }

    // Return the query snapshot (or any other relevant data)
    return snapshot;
  }



}
