import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;

import '../../bloc/posts/posts_bloc.dart';

class AddVideoPost extends StatefulWidget {
  const AddVideoPost({Key? key}) : super(key: key);

  @override
  State<AddVideoPost> createState() => _AddVideoPostState();
}

class _AddVideoPostState extends State<AddVideoPost> {
  String? _videoSrc;
  String? videoAsBase64;
  String? fileName;
  String _localVideoPlayerId = 'local-video-player';
  final VideoSetup _videoSetup = VideoSetup();
  VideoData videoData=VideoData(url: "",base64: "",fileName: "");
  Future<void> _registerNativeVideoPlayer() async {
    videoData = await _videoSetup.getLocalVideoUrl();
    _videoSrc=videoData.url;
    videoAsBase64=videoData.base64;
    fileName=videoData.fileName;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        _localVideoPlayerId, (int id) => _videoSetup.createVideoElement(_videoSrc!));

    BlocProvider.of<PostsBloc>(context).add(AddVideoPostEvent(videoBase64: "data:video/${fileName!.split('.').last};base64,${videoAsBase64!}"));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: () async{
              _registerNativeVideoPlayer();
            },
            child: Stack(
              children: [
                DottedBorder(
                  strokeWidth: 2.w,
                  color: Colors.black87,
                  dashPattern: [6, 3, 2, 1],
                  child: GestureDetector(

                    child: Container(
                      width: 500.w,
                      height: 300.h,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 30).w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20).w,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (_videoSrc == null)
                            Center(
                              child: Icon(
                                Icons.video_call_outlined,
                                size: 70.w,
                              ),
                            )
                          else
                            SizedBox(
                              width: 400,
                              height: 200,
                              child: HtmlElementView(viewType: _localVideoPlayerId),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(onPressed: (){
                      setState(() {

                        if(_videoSrc!=null){
                          html.document.getElementById(_videoSrc!)?.remove();
                          _videoSrc=null;
                        }

                        videoAsBase64=null;
                        fileName=null;
                        _localVideoPlayerId = 'local-video-player';
                        _registerNativeVideoPlayer();
                      });
                    }, icon: Icon(Icons.edit)))
              ],
            ),
          ),
        ),
      ],
    );
  }
}




/// dummy class to resolve dart:ui and analyzer issues
class platformViewRegistry {
  static registerViewFactory(String viewId, dynamic cb) {}
}


class VideoSetup {
  /// to upload a video from the system
  /// and create a url from it
  Future <VideoData> getLocalVideoUrl() async {
    final completer = Completer<VideoData>();
    // create input element to upload video file from the system
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'video/*';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;

      if (files!.length > 0) {
        final file = files[0];
        final reader = html.FileReader();
        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen((e) {
          final encoded = reader.result as String;
          // remove the metadata at the beginning of the base64 string
          final base64 = encoded.replaceFirst(RegExp(r'data:video/.*;base64,'), '');
          // create the URL for displaying the video
          final url = html.Url.createObjectUrl(file);
          // get the filename
          final filename = file.name;
          completer.complete(VideoData(url :url,base64: base64,fileName:filename ));
        });
      }
    });
    return completer.future;
  }


  /// to create a video element with provided src
  html.VideoElement createVideoElement(String src) {
    return html.VideoElement()
      ..controls = true
      ..autoplay = false
      ..src = src;
  }
}





class VideoData {
  final String url;
  final String base64;
  final String fileName;
  VideoData({required this.url,required this.base64 ,required this.fileName});
}