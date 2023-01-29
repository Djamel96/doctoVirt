import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const int sendTimeOut = 10000;
const int recieveTimeOut = 20000;

/// This functions allow to get and post data to server

Future<Response?> dioPostFormdata(
    {required String url,
    FormData? formData,
    required String token,
    Map<String, dynamic>? parameters,
    int timeOut = sendTimeOut}) async {
  Response response;
  Dio dio = Dio();
  var header = {
    "Accept": 'application/json',
    //"Content-Type": "multipart/form-data",
    "Authorization": token
  };
  debugPrint(url);

  try {
    response = await dio.post(
      url,
      data: formData,
      queryParameters: parameters,
      options: Options(
          headers: header,
          sendTimeout: timeOut,
          receiveTimeout: recieveTimeOut),
    );
    return response;
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.type == DioErrorType.connectTimeout) {
      return e.response;
    }
    if (e.response != null) {
      debugPrint(e.response?.statusCode.toString().toString());
      debugPrint("response = ${e.response?.data}");
      debugPrint(e.response?.headers.toString().toString());
      debugPrint(e.response?.requestOptions.toString().toString());
      return e.response;
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      debugPrint(e.requestOptions.toString().toString());
      debugPrint(e.message);
      return e.response;
    }
  }
}

Future<Response?> dioPostRow(
    {required String url,
    var data,
    required String token,
    Map<String, dynamic>? parameters}) async {
  Response response;
  Dio dio = Dio();

  var header = {
    "Authorization": token,
    "Accept": 'application/json',
    "Content-Type": "application/json"
  };
  debugPrint(url);

  try {
    response = await dio.post(
      url,
      data: data,
      options: Options(
          headers: header,
          sendTimeout: sendTimeOut,
          receiveTimeout: recieveTimeOut),
    );
    return response;
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.type == DioErrorType.connectTimeout) {
      return e.response;
    }
    if (e.response != null) {
      debugPrint(e.response?.statusCode.toString());
      debugPrint("response = ${e.response?.data}");
      debugPrint(e.response?.headers.toString());
      debugPrint(e.response?.requestOptions.toString());
      return e.response;
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      debugPrint(e.requestOptions.toString());
      debugPrint(e.message);
      return e.response;
    }
  }
}

Future<Response?> dioPostUrlEncoded(
    {required String url,
    var formData,
    required String token,
    Map<String, dynamic>? parameters}) async {
  Response response;
  Dio dio = new Dio();
  var header = {
    "Accept": "x-www-form-urlencoded",
    "Content-Type": 'application/json',
    "Authorization": token
  };
  debugPrint(url);

  try {
    response = await dio.post(
      url,
      data: formData,
      queryParameters: parameters,
      options: Options(
          headers: header,
          sendTimeout: sendTimeOut,
          receiveTimeout: recieveTimeOut),
    );
    return response;
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.type == DioErrorType.connectTimeout) {
      return e.response;
    }
    if (e.response != null) {
      debugPrint(e.response?.statusCode.toString());
      debugPrint("response = ${e.response?.data}");
      debugPrint(e.response?.headers.toString());
      debugPrint(e.response?.requestOptions.toString());
      return e.response;
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      debugPrint(e.requestOptions.toString());
      debugPrint(e.message);
      return e.response;
    }
  }
}

Future<Response?> dioget(
    {required String url,
    required String token,
    Map<String, dynamic>? parameters}) async {
  Response response;
  Dio dio = Dio();
  log("***** ulr = $url");
  var header = {
    "Authorization": token,
    // "Accept": 'application/json',
    // "Content-Type": "application/json"
  };

  try {
    response = await dio.get(url,
        options: Options(
            headers: header,
            sendTimeout: sendTimeOut,
            receiveTimeout: recieveTimeOut),
        queryParameters: parameters);
    return response;
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.type == DioErrorType.connectTimeout) {
      return e.response;
    }
    if (e.response != null) {
      // debugPrint(e.response?.statusCode.toString());
      // debugPrint("response = ${e.response?.data}");
      // debugPrint(e.response?.headers.toString());
      // debugPrint(e.response?.requestOptions.toString());
      return e.response;
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      // debugPrint(e.requestOptions.toString());
      // debugPrint(e.message);
      return e.response;
    }
  }
}

Future<Response?> dioPutRow(
    {required String url,
    var data,
    String? token,
    Map<String, dynamic>? parameters}) async {
  Response response;
  Dio dio = new Dio();

  var header = {
    "Authorization": token,
    "Accept": 'application/json',
    "Content-Type": "application/json"
  };
  debugPrint(url);

  try {
    response = await dio.put(
      url,
      data: data,
      queryParameters: parameters,
      options: Options(
          headers: header,
          sendTimeout: sendTimeOut,
          receiveTimeout: recieveTimeOut),
    );
    return response;
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.type == DioErrorType.connectTimeout) {
      return e.response;
    }
    if (e.response != null) {
      debugPrint(e.response?.statusCode.toString());
      debugPrint("response = ${e.response?.data}");
      debugPrint(e.response?.headers.toString());
      debugPrint(e.response?.requestOptions.toString());
      return e.response;
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      debugPrint(e.requestOptions.toString());
      debugPrint(e.message);
      return e.response;
    }
  }
}

Future<Response?> dioPutFormdata(String url, FormData formData, String token,
    Map<String, dynamic>? parameters,
    {int? sendTimeout}) async {
  Response response;
  Dio dio = new Dio();
  var header = {
    "Accept": 'application/json',
    //"Content-Type": "multipart/form-data",
    "Authorization": token
  };

  debugPrint("dioPutFormdata url = $url");

  try {
    response = await dio.put(
      url,
      data: formData,
      queryParameters: parameters,
      options: Options(
          headers: header,
          sendTimeout: sendTimeout ?? sendTimeOut,
          receiveTimeout: recieveTimeOut),
    );
    return response;
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.type == DioErrorType.connectTimeout) {
      return e.response;
    }
    if (e.response != null) {
      debugPrint(e.response?.statusCode.toString());
      debugPrint("response = ${e.response?.data}");
      debugPrint(e.response?.headers.toString());
      debugPrint(e.response?.requestOptions.toString());
      return e.response;
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      debugPrint(e.requestOptions.toString());
      debugPrint(e.message);
      return e.response;
    }
  }
}

Future<Response?> dioDelelet(String url, var data, String token,
    Map<String, dynamic>? parameters) async {
  Response response;
  Dio dio = new Dio();

  var header = {
    "Authorization": token,
    "Accept": 'application/json',
    "Content-Type": "application/json"
  };
  debugPrint(url);

  try {
    response = await dio.delete(
      url,
      data: data,
      queryParameters: parameters,
      options: Options(
          headers: header,
          sendTimeout: sendTimeOut,
          receiveTimeout: recieveTimeOut),
    );
    return response;
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.type == DioErrorType.connectTimeout) {
      return e.response;
    }
    if (e.response != null) {
      debugPrint(e.response?.statusCode.toString());
      debugPrint("response = ${e.response?.data}");
      debugPrint(e.response?.headers.toString());
      debugPrint(e.response?.requestOptions.toString());
      return e.response;
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      debugPrint(e.requestOptions.toString());
      debugPrint(e.message);
      return e.response;
    }
  }
}
