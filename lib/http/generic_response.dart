// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class GenericResponse {
  int? statusCode;
  bool success;
  String resCode;
  String successMessage;
  String errorMessage;
  var value;

  GenericResponse({
    this.statusCode,
    required this.resCode,
    required this.success,
    this.successMessage = "",
    this.errorMessage = "",
    this.value,
  });

  static defaultError({String? errorMessage, String? resCode}) =>
      GenericResponse(
          statusCode: 400,
          success: false,
          errorMessage: errorMessage ?? DEFAULT_ERROR_MESSAGE,
          resCode: resCode ?? DEFAUL_ERROR_CODE);

  static defaultSuccess({String? successMessage, var value}) => GenericResponse(
      statusCode: 200,
      success: true,
      successMessage: successMessage ?? "",
      resCode: DEFAULT_SUCCES_CODE,
      value: value);
}

const DEFAULT_SUCCES_CODE = "DEFAULT_SUCCES_CODE";
const DEFAUL_ERROR_CODE = "DEFAUL_ERROR";
const DEFAULT_ERROR_MESSAGE = "An error occured";

/// Custom error codes
const INVALIDE_CODE = "invalid_code";
const EMAIL_NOT_FOUND = "email_not_found";
const WRONG_EMAIL_OR_PASSWORD = "wrong_email_or_password";
const emailAlreadyExist = "email_exist";
const emailNotVerified = "email_not_verified";
const userIsApplicant = 'userIsApplicant';

/// Online offline response status for permanant staff
const ONLINE = "online";
const OFFLINE = "offline";
const APPROVAL_NEEDED = "approval_needed";

bool successResponse(int? code) {
  debugPrint("****** status code = $code");
  if (code == null) return false;
  bool res = code >= 200 && code <= 301;
  debugPrint("succesResponse res = $res ");
  return res;
}
