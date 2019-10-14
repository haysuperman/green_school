/*
 * ====================================================
 * package   : net
 * author    : Created by nansi.
 * time      : 2019/3/21  4:06 PM 
 * remark    : 
 * ====================================================
 */

import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:green_school/config/Config.dart';
import 'package:green_school/net/ResultData.dart';

typedef OnSuccess<T> = Function(T data, int code, String msg);
typedef OnFailure = Function(int code, String msg);

class HttpManager {
  static const SUCCESS = 1000;
  static const FAILURE = 999;
  static const ERROR = -1;

  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static Future<ResultData> netFetch(url, params, Map<String, String> header, Options option,
      {noTip = false}) async {
    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    ///超时
    option.connectTimeout = 15000;

    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.request<String>(url, data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = ERROR;
      }
      if (Config.debug) {
        print('请求异常: ' + e.toString());
        print('请求异常url: ' + url);
      }
      return new ResultData(null, false, errorResponse.statusCode);
    }

    if (Config.debug) {
      print('请求url: ' + url);
      print('请求头: ' + option.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
      if (optionParams["authorizationCode"] != null) {
        print('authorizationCode: ' + optionParams["authorizationCode"]);
      }
    }
    return new ResultData(response.data, true, SUCCESS);
  }

  static Future<ResultData> post(url, params, {Map<String, String> header, Options option, noTip = false}) async{
    if (option != null) {
      option.method = "post";
    } else {
      option = new Options(method: "post");
    }
    return await netFetch(url, params, header, option);
  }
}
