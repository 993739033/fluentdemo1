import 'dart:io';

import 'package:file_picker/file_picker.dart';


Future<File> openSingleFile() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt','log']
  );
  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  }
  return File("");
}

Future<FilePickerResult?> openSingleFile2() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  return result;
}


Future<String> saveFile() async{
  String? outputFile = await FilePicker.platform.saveFile(
    dialogTitle: 'Please select an output file:',
    fileName: 'download.apk',
  );
  return outputFile??"";
}
