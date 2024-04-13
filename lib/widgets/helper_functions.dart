import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../ui/loader.dart';

class HelperFunctions {
  static void showLoader(BuildContext context) {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: const Color.fromARGB(133, 0, 0, 0),
            child: const CustomLoader(),
          );
        });
  }

  static void closeLoader(BuildContext context) {
    Navigator.pop(context);
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  static String? stringValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid value';
    }
    return null;
  }

  static void decodeBase64NSaveLocally(String base64String) async {
    List<int> bytes = base64Decode(base64String);
    String? directory = (await getExternalStorageDirectory())!.path;
    await File('$directory/decoded_file.pdf').writeAsBytes(bytes);
  }

  static Future<FilePickerResult?> filePicker() async {
    final permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      await Permission.storage.request();

      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      var result = await FilePicker.platform.pickFiles(
          withReadStream: true,
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowMultiple: false);

      if (result != null) {
        return result;
      }
      return null;
    }
    return null;
  }

  static Future<String> encodeFile(File filePath) async {
    List<int> bytes = await filePath.readAsBytes();
    String base64String = base64Encode(bytes);
    return base64String;
  }
}
