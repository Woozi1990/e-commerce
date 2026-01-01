import 'package:get/get.dart';

import '../widgets/user.dart';

class UserController extends GetxController{
  var user = UserInfo.fromJSON({}).obs;

  void updateUserInfo(UserInfo userInfo) {
    user.value = userInfo;
  }
  void clearUserInfo() {
    user.value = UserInfo.fromJSON({});
  }

}