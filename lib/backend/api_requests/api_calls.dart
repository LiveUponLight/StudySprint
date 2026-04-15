import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_commons/api_requests/api_manager.dart';


export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GenerateStudyPlanCall {
  static Future<ApiCallResponse> call({
    String? syllabus = '',
  }) async {
    final ffApiRequestBody = '''
{
  "syllabus": "${escapeStringForJson(syllabus)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'generateStudyPlan',
      apiUrl:
          'https://us-central1-api-host-5fd93.cloudfunctions.net/generateStudyPlan',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic title(dynamic response) => getJsonField(
        response,
        r'''$.title''',
      );
  static dynamic weeks(dynamic response) => getJsonField(
        response,
        r'''$.weeks''',
      );
  static dynamic totalWeeks(dynamic response) => getJsonField(
        response,
        r'''$.totalWeeks''',
      );
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
