import 'package:e_commerce/constants/index.dart';
import 'package:e_commerce/utils/dio_request.dart';
import 'package:e_commerce/widgets/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> params) async {
  return UserInfo.fromJSON(
    await dioRequest.post(
      HttpConstants.login,
      params: params,
    ),
  );
}