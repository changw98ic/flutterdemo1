import 'package:extended_image/extended_image.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CommonWidget extends StatelessWidget {
  CommonWidget({
    this.child,
    this.title,
  });

  final Widget child;
  final String title;
  final GlobalKey<ExtendedImageEditorState> editorKey =GlobalKey<ExtendedImageEditorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: ExtendedImage.network(
        imageTestUrl,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: editorKey,
        initEditorConfigHandler: (state) {
          return EditorConfig(
              maxScale: 8.0,
              cropRectPadding: EdgeInsets.all(20.0),
              hitTestSize: 20.0,
              // cropAspectRatio: _aspectRatio.aspectRatio
          );
        }
      ),
    );
  }
}

String get imageTestUrl => 'https: //photo.tuchong.com/4870004/f/298584322.jpg';