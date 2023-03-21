import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctovirt/http/dio_requests.dart';
import 'package:doctovirt/http/generic_response.dart';

import '../../http/api.dart';

/// Load the agora token from server
Future<GenericResponse> getAgoraToken() async {
  return GenericResponse.defaultSuccess(
    value:
        "00685559cb7b6bb4bd9b8725f1fae06a4baIAAnC0RAPe1+hLQqnW29ilh4YYWXtOswrXoepK+Fo0Hv3ZQARWYAAAAAIgCaJasCg/oWZAQAAQADTBhkAwADTBhkAgADTBhkBAADTBhk",
  );
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
          value:
              "00685559cb7b6bb4bd9b8725f1fae06a4baIAAnC0RAPe1+hLQqnW29ilh4YYWXtOswrXoepK+Fo0Hv3ZQARWYAAAAAIgCaJasCg/oWZAQAAQADTBhkAwADTBhkAgADTBhkBAADTBhk",
        );
      }
    }
  } catch (e) {
    return GenericResponse.defaultError();
  }
  return GenericResponse.defaultError();
}
