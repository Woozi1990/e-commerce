import 'package:dio/dio.dart';
import 'package:e_commerce/constants/index.dart';

class DioRequest {
  final _dio = Dio();
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.baseUrl
      ..connectTimeout = Duration(seconds: GlobalConstants.timeOutSecond)
      // ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.timeOutSecond);
    _addInterceptor();
  }
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          handler.next(request);
        },
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstants.successCode) {
        return data["result"];
      }
      throw Exception(data["msg"] ?? "加载数据");
    } catch (e) {
      throw Exception(e);
    }
  }
}

final dioRequest = DioRequest();
