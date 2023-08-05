import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kavach_2/src/repository/user_repository/user_repository.dart';

import '../models/user_model.dart';

class RegistrationController extends GetxController{
  static RegistrationController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  Future<void> createUser(UserModel user) async {

    await userRepo.createUser(user);
    }
}
