import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bean/T1Bean.dart';
import 'LogUtil.dart';


Future<T1Bean?> showAddDialog(BuildContext context) async {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.blue[100],
          child: IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.green[100],
              child: Column(
                children: [
                  Text("添加数据"),
                  Padding(padding: EdgeInsets.all(10)),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text("name:"),
                      ),
                      Expanded(
                          flex: 2,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                    gapPadding: 2),
                                labelText: "请输入名称"),
                            controller: controllerName,
                          ))
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("age:")),
                      Expanded(
                          flex: 2,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                    gapPadding: 2),
                                labelText: "请输入年龄"),
                            controller: controllerAge,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ))
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Spacer()),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel")),
                      TextButton(
                          onPressed: () {
                            String name = controllerName.text;
                            String age = controllerAge.text;
                            T1Bean t1bean = T1Bean(-1, name, int.parse(age));
                            LogUtil.e("add pop ${t1bean.toJson()}");
                            Navigator.of(context).pop(t1bean);
                          },
                          child: Text("Enter")),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

Future<int?> showBottomDialog1(BuildContext context) async {
  return showModalBottomSheet(
      context: context,
      builder: (c) {
        return Container(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "blue",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(Colors.blue.value);
                },
              ),
              ListTile(
                title: Text("cyan",
                    style: TextStyle(
                      color: Colors.cyan,
                    )),
                onTap: () {
                  Navigator.of(context).pop(Colors.cyan.value);
                },
              ),
              ListTile(
                title: Text("teal",
                    style: TextStyle(
                      color: Colors.teal,
                    )),
                onTap: () {
                  Navigator.of(context).pop(Colors.teal.value);
                },
              ),
              ListTile(
                title: Text("green",
                    style: TextStyle(
                      color: Colors.green,
                    )),
                onTap: () {
                  Navigator.of(context).pop(Colors.green.value);
                },
              ),
              ListTile(
                title: Text("red",
                    style: TextStyle(
                      color: Colors.red,
                    )),
                onTap: () {
                  Navigator.of(context).pop(Colors.red.value);
                },
              ),
            ],
          ),
        );
      });
}


Future<String?> showBottomDialog2(BuildContext context) async {
  return showModalBottomSheet(
      context: context,
      builder: (c) {
        return Container(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "English",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop("en");
                },
              ),
              ListTile(
                title: Text("中文",
                    style: TextStyle(
                      color: Colors.cyan,
                    )),
                onTap: () {
                  Navigator.of(context).pop("zh_CN");
                },
              ),
              ListTile(
                title: Text("日文",
                    style: TextStyle(
                      color: Colors.teal,
                    )),
                onTap: () {
                  Navigator.of(context).pop("ja");
                },
              ),
            ],
          ),
        );
      });
}