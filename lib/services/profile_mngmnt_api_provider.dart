import 'dart:convert';

import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/api_routes.dart';
import '../model/response_payload.dart';

class ProfileManagementAPIProvider {
  static final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  static Future<ApiResponse<GenericResponse>> secondStageUserOnboard(
      String? payload) async {
    final Uri url = Uri.parse('${APIRoutes.profileServiceUrl}/UploadFile');
    print('${APIRoutes.profileServiceUrl}/user-onboarding');
    print('here');
    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final Map<String, dynamic> mappedResponse = json.decode(response.body);
        final ApiResponse<GenericResponse> generateOtpResponse =
            ApiResponse.fromJson(mappedResponse, GenericResponse.fromJson);

        logger.i('otp request succesful: ${generateOtpResponse.isSuccess}');
        return generateOtpResponse;
      });
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  // static Future<ApiResponse<GenericResponse>> secondStageUserOnboard(
  //     String? path, String filename) async {
  //   final Uri url = Uri.parse('${APIRoutes.profileServiceUrl}/UploadFile');
  //   print('${APIRoutes.profileServiceUrl}/user-onboarding');
  //   print('here');
  //   try {
  //     var request = http.MultipartRequest('POST', url);

  //   String url = '${APIRoutes.profileServiceUrl}/UploadFile'; // change it with your api url
  //   ChunkedUploader chunkedUploader = ChunkedUploader(
  //     Dio(
  //       BaseOptions(
  //         baseUrl: url,
  //         headers: {
  //           'Content-Type': 'multipart/form-data',
  //           'Connection': 'Keep-Alive',
  //         },
  //       ),
  //     ),
  //   );

  //   try {
  //     Response? response = await chunkedUploader.upload(
  //       fileKey: "file",
  //       method: "POST",
  //       filePath: path,
  //       maxChunkSize: 500000000,
  //       path: url,
  //       data: {
  //         'additional_data': 'hiii',
  //       },
  //       onUploadProgress: (v) {
  //         if (kDebugMode) {
  //           print(v);
  //         }
  //       },
  //     );
  //     if (kDebugMode) {
  //       print(response);
  //     }

  //   } on DioError catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }}

  //   //   return http.post(url, body: payload, headers: {
  //   //     'Content-Type': 'application/json',
  //   //   }).then((http.Response response) {
  //   //     final Map<String, dynamic> mappedResponse = json.decode(response.body);
  //   //     final ApiResponse<GenericResponse> generateOtpResponse =
  //   //         ApiResponse.fromJson(mappedResponse, GenericResponse.fromJson);

  //   //     logger.i('otp request succesful: ${generateOtpResponse.isSuccess}');
  //   //     return generateOtpResponse;
  //   //   });
  //   // } catch (error) {
  //   //   print(error);
  //   //   rethrow;
  //   // }
  // }
}
