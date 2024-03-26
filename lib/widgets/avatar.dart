import 'dart:io';

import 'package:closet_app/locator.dart';
import 'package:closet_app/model/user_model.dart';
import 'package:closet_app/services/fire_auth.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatelessWidget {

  UserModel currentUser = locator.get<UserController>().currentUser;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() async {
        XFile image =ImagePicker().pickImage(source: ImageSource.gallery,) as XFile;
        if (image != null) {
          await locator
              .get<UserController>()
              .uploadProfilePicture(File(image.path));


        }
      },
      child: Center(
        child: currentUser.avatarUrl == ""
            ? CircleAvatar(
          radius: 50.0,
          child: Icon(Icons.photo_camera),
        )
            : CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(currentUser.avatarUrl!),
        ),
      ),
    );
  }
}
