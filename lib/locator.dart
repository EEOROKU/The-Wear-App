import 'package:closet_app/services/fire_auth.dart';
import 'package:closet_app/services/storage_repo.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  locator.registerSingleton<UserController>(UserController());

}
