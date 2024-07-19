import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import '../bean/T1Bean.dart';
import '../utils/FileUtil.dart';
import '../utils/LogUtil.dart';

class NetClient {
  NetClient([this.context]) {}

  BuildContext? context;

  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'http://47.102.202.2:8888',
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
          "application/vnd.github.symmetra-preview+json",
    },
  ));

  static void init() {
    // // 添加缓存插件
    // dio.interceptors.add(Global.netCache);
    // // 设置用户token（可能为null，代表未登录）
    // dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    // if (!Global.isRelease) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     // client.findProxy = (uri) {
    //     //   return 'PROXY 192.168.50.154:8888';
    //     // };
    //     //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }

  //http://47.102.202.2:8888/t1/getlist
  Future<List<T1Bean>> getT1List({Map<String, dynamic>? requestMap}) async {
    var r = await dio.get<List>("/t1/getlist", queryParameters: requestMap);
    // await Duration(seconds: 3);
    return r.data!.map((e) => T1Bean.fromJson(e)).toList();
  }

  Future<String?> addT1Bean(T1Bean bean) async {
    var r = await dio.post<String>("/t1/add",
        queryParameters: {"name": bean.name, "age": bean.age});
    // await Duration(seconds: 3);
    return r.data;
  }

  Future<String?> deleteT1Bean(int id) async {
    var r = await dio.post<String>("/t1/delete", queryParameters: {"id": id});
    return r.data;
  }

  static Future<String?> updateFile(Uint8List bytes, String fileName) async {
    try {
      if (bytes == null) {
        return "canceled";
      }
      var uploadFile =
          await MultipartFile.fromBytes(bytes, filename: fileName);
      var formData = FormData.fromMap({
        'file': uploadFile,
      });
      Response<String> response = await dio.post(
        "/upload",
        data: formData,
        onSendProgress: (send, total) {
          LogUtil.e("$send/$total");
          final currentProgress = (send / total);
          // EasyLoading.showProgress(currentProgress,
          //     status: '${(currentProgress * 100).toStringAsFixed(0)}%');
          // if (currentProgress >= 1) {
          //   EasyLoading.dismiss();
          // }
        },
      );
      return response.data ?? "error";
    } catch (e) {
      // EasyLoading.dismiss();
      LogUtil.e(e.toString());
      // EasyLoading.showToast("错误:" + e.toString());
      return "err:${e.toString()}";
    }
  }
}
