import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctovirt/http/dio_requests.dart';
import 'package:doctovirt/http/generic_response.dart';

import '../../http/api.dart';

Future<GenericResponse> getAgoraToken() async {
  try {
    Response? response;
    await dioget(
      url: Api.getAgoraToken,
      parameters: null,
      token: '',
    ).then((onValue) {
      response = onValue;
    });
    if (response != null) {
      log(response!.data.toString());
      if (successResponse(response!.statusCode)) {
        return GenericResponse.defaultSuccess(
          value: response!.data['data']['android_store_link'],
        );
      }
    }
  } catch (e) {
    return GenericResponse.defaultError();
  }
  return GenericResponse.defaultError();
}
