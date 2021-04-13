import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'api.dart';

class HttpManager {
  Dio _dio;
  static HttpManager _instance;

  factory HttpManager.getInstance() {
    if (null == _instance) {
      _instance = new HttpManager._internal();
    }
    return _instance;
  }

  //以 _ 开头的函数、变量无法在库外使用
  HttpManager._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: Api.base_url, //基础地址
      connectTimeout: 5000, //连接服务器超时时间，单位是毫秒
      receiveTimeout: 3000, //读取超时
    );
    _dio = new Dio(options);
  }

  requestGet(url, {data, String method = "get"}) async {
    try {
      Options option = new Options(method: method);
      Response response = await _dio.request(url, data: data, options: option);
      return response.data;
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  requestPost(url, {data, String method = "post"}) async {
    try {
      Options option = new Options(method: method);
      Response response = await _dio.request(url, data: data, options: option);
      return response.data;
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }
}
