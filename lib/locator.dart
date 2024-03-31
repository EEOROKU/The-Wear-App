
import 'package:closet_app/view_controller/backend_service.dart';
import 'package:closet_app/view_controller/user_controller.dart';

import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupServices() {
  // Initialize BackendService
  BackendService backendService = BackendService();

  // Register BackendService in the locator
  locator.registerSingleton<BackendService>(backendService);
  UserController userController = UserController(backendService);
  userController.initUser();
  // Register UserController in the locator
  locator.registerSingleton<UserController>(userController); // Pass the BackendService instance to the UserController constructor
}