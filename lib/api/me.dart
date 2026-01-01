import 'package:e_commerce/constants/index.dart';
import 'package:e_commerce/models/me.dart';
import 'package:e_commerce/utils/dio_request.dart';

Future<MeRecommendItem> getMeRecommendListAPI(
  Map<String, dynamic> params,
) async {
  return MeRecommendItem.formJSON(
    await dioRequest.get(HttpConstants.meRecommendList, params: params),
  );
} 