import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app04/pages/utils/ImagePreview.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:typed_data';

import 'model/UserInfoModule.dart';

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<Asset> _img = new List<Asset>();
  UserInfoItemModel _userInfo = UserInfoItemModel();
  ScrollController _imgController = new ScrollController();

  @override
  void initState() {
    super.initState();
    this._getUserInfo();
  }

  _getUserInfo() async {
    var api =
        'http://82.156.253.5:8080/yuanqi/userInfo/findByNumPhone?numPhone=17763122203';
    Response response = await Dio().get(api);
    if (response.data["resultCode"] == 200) {
      var userInfo = UserInfoModel.fromJson(response.data);
      setState(() {
        this._userInfo = userInfo.data;
      });
    }
  }

  /// 图片压缩 Uint8List -> Uint8List
  Future<Uint8List> _uint8CompressList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 60,
      rotate: 0,
    );
    print(list.length);
    print(result.length);
    return result;
  }

//提交数据
  void _submitData() async {
    List<MultipartFile> imageList = new List<MultipartFile>();
    for (Asset asset in _img) {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      imageData = await _uint8CompressList(imageData);
      MultipartFile multipartFile = new MultipartFile.fromBytes(
        imageData,
        filename: 'load_image',
        contentType: MediaType("image", "jpg"),
      );
      imageList.add(multipartFile);
    }

    FormData formData = new FormData.fromMap({
      //后端要用multipartFiles接收参数，否则为null
      "multipartFiles": imageList,
      "id": this._userInfo.id
    });
    var api = 'http://82.156.253.5:8080/yuanqi/userInfo/update';
    Response response = await Dio().post(api, data: formData);
    if (response.data['resultCode'] == 200) {
      var api =
          'http://82.156.253.5:8080/yuanqi/userInfo/findByNumPhone?numPhone=17763122203';
      Response response = await Dio().get(api);
      if (response.data["resultCode"] == 200) {
        var userInfo = UserInfoModel.fromJson(response.data);
        setState(() {
          this._userInfo = userInfo.data;
        });
      }
    }
  }

//选择文件上传
  void _openGallerySystem() async {
    List<Asset> resultList = List<Asset>();
    resultList = await MultiImagePicker.pickImages(
      maxImages: 9,
      enableCamera: true,
      selectedAssets: _img,
      materialOptions: MaterialOptions(
          startInAllView: true,
          allViewTitle: '所有照片',
          actionBarColor: '#2196F3',
          textOnNothingSelected: '没有选择照片',
          selectionLimitReachedText: "最多选择9张照片"),
    );
    if (!mounted) return;
    setState(() {
      _img = resultList;
      this._submitData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            "入职测试",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: ListView(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                  height: 60,
                  child: InkWell(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: ImagePreview(image: this._userInfo.headPic??'', width: 100.0, height: 36.0,)
                        ),
                        Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap:_openGallerySystem,
                                  child: Text(
                                    "编辑头像",
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                ),
                              ],
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
