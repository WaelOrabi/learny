import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DisplayVideo extends StatefulWidget {
  final String videoUrl;
  const DisplayVideo({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<DisplayVideo> createState() => _DisplayVideoState();
}

class _DisplayVideoState extends State<DisplayVideo> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoInitialize: true,
      looping: false,
      autoPlay: false,
      errorBuilder: (context, errorMessage) {
        return Center(child: Text(errorMessage, style: const TextStyle(color: Colors.white)));
      },
    );
  }
@override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(10).w,
      ),
      width: 800.w,
      height: 450.h,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
