
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class ImageCardWidget extends StatelessWidget {
   final String image;
    final double heightImage;
     final double widthImage;
     final double circular;
  const ImageCardWidget({Key? key, required this.image, this.heightImage=200, this.widthImage=300, this.circular=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: heightImage,
      width: widthImage,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(circular),
          child:Image.network(image,fit: BoxFit.fill,scale: 1,)),
    );
  }
}
