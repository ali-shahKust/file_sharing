import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CustomVideoThumbnail extends StatefulWidget {
  final String path;

  CustomVideoThumbnail({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  _CustomVideoThumbnailState createState() => _CustomVideoThumbnailState();
}



class _CustomVideoThumbnailState extends State<CustomVideoThumbnail>

    with AutomaticKeepAliveClientMixin {

  Uint8List ? thumb;
  Future<void> getThumbnail()async{
    Uint8List? thumbnailData = await VideoThumbnail.thumbnailData(
          video: widget.path,

          imageFormat: ImageFormat.JPEG,
          maxWidth: 200,
          // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          quality: 25,
        );
    setState(() {
      thumb = thumbnailData;
    });

    // return thumb;
  }


  bool loading = true;
  late VideoPlayerController _controller;

//  getThumb() async{
//    var dir = await getExternalStorageDirectory();
//    String thumbnail = await Thumbnails.getThumbnail(
//      thumbnailFolder: dir.path,
//      videoFile: widget.path,
//      imageType: ThumbFormat.PNG,
//      quality: 30,
//    );
//    setState(() {
//      thumb = thumbnail;
//      loading = false;
//    });
//  }

  @override
  void initState() {
    super.initState();
     getThumbnail().whenComplete((){
       if(mounted) {
               setState(() {
                 loading = false;
               }); //when your thumbnail will show.
             }
     });
    // _controller = VideoPlayerController.file(File(widget.path))
    //   ..initialize().then((_) {
    //     if(mounted) {
    //       setState(() {
    //         loading = false;
    //       }); //when your thumbnail will show.
    //     }
    //   });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? Image.asset(
            'assets/file_manager_assets/video-placeholder.png',
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          )
        : Image.memory(thumb!,
      height: 40,
      width: 40,
      fit: BoxFit.cover,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
