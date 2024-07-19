import 'package:flutter/cupertino.dart';

abstract class BaseNotifier<T> extends ChangeNotifier {
  late T _data ;
  int temp =1;


  T get data {
    return _data;
  }

  set data(T value) {
    _data = value;
  }

  BaseNotifier(){
  }


  //初始化 读取持久化设置
  Future<T> init();

  //保存数据
  void saveData(T data);

  @override
  void notifyListeners() {
    super.notifyListeners();
    if(_data!=null) {
      saveData(_data);
    }
  }
}
