import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ImagePage.dart';

// ignore: must_be_immutable
class ImagePreview extends StatelessWidget {
  double height = 0;
  double width = 0;
  String image = '';

  ImagePreview({
    Key key,
    @required this.height,
    @required this.width,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: image != null
          ? Align(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  // 展示大图
                  Container(
                    child: ImagePage(
                        childWidget: image.startsWith('/storage')
                            ? Image.file(
                                File(image),
                                height: 36.0,
                              )
                            : CircleAvatar(
                                radius: 36.0,
                                backgroundImage: NetworkImage(image??''),
                              ),
                        imageURL: image,
                        context: context),
                  )
                ],
              ),
            )
          : Text(''),
    );
  }
}
