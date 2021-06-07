/*
 * 大图查看
 * Author: liuyilan
 * Date: 2020-5-8
 * */

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_drag_scale/core/drag_scale_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';

// ignore: must_be_immutable
class ImagePage extends StatefulWidget {
  Widget childWidget;
  String imageURL; // 图片链接
  var fileImage; // 图片文件（与链接二选一）
  BuildContext context;

  ImagePage({this.childWidget, this.context, this.imageURL, this.fileImage});

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  static ProgressDialog pr ;

  static Future<void> downloadCallback(
      String id, DownloadTaskStatus status, int progress) async {
    if(status == DownloadTaskStatus.complete){
      isCompleted = true;
    }
  }

  static bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    ProgressDialog pr = new ProgressDialog(context, type: ProgressDialogType.Download);
    // 设置下载回调
  }

  @override
  Widget build(BuildContext context) {
    String photoUrl = widget.imageURL;
    return GestureDetector(
      child: widget.childWidget,
      onTap: () {
        Navigator.of(context)
            .push(PageRouteBuilder(pageBuilder: (ctx, animation, animation2) {
          return FadeTransition(
            opacity: animation,
            child: Scaffold(
              appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_outlined),onPressed: (){Navigator.pop(context);},),),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  if(index == 1){
                  _doDownloadOperation();
                  }else{

                  }
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.search),label: '缩放'),
                  BottomNavigationBarItem(icon: Icon(Icons.download_sharp),label: '保存'),
                ],
              ),
              backgroundColor: Colors.black,
              body: Center(
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(widget.context);
                      },
                      child: !photoUrl.contains('http://')
                          ? DragScaleContainer(
                            child: Image.file(
                                File(photoUrl),
                                fit: BoxFit.fill,
                              ),
                          )
                          : DragScaleContainer(
                            child: Image.network(
                                photoUrl,
                                fit: BoxFit.fill,
                              ),
                          ))),
            ),
          );
        }));
      },
    );
  }

  // 申请权限
  Future<bool> _checkPermission() async {
    // 先对所在平台进行判断
    if (Theme.of(context).platform == TargetPlatform.android) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  // 获取存储路径
  Future<String> _findLocalPath() async {
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    return directory.path;
  }

  _downloadFile(downloadUrl, savePath) async {
    await FlutterDownloader.enqueue(
      url: downloadUrl,
      savedDir: savePath,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  Future<bool> _openDownloadedFile(taskId) {
    return FlutterDownloader.open(taskId: taskId);
  }

  Future<void> _doDownloadOperation() async {
    // 获取存储路径
    var _localPath = (await _findLocalPath()) + '/Download';

    final savedDir = Directory(_localPath);
// 判断下载路径是否存在
    bool hasExisted = await savedDir.exists();
// 不存在就新建路径
    if (!hasExisted) {
      savedDir.create();
    }
    String reqPath = widget.imageURL;
    await _downloadFile(reqPath, _localPath);
  }
}
