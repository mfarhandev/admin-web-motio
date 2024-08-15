import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:motion_web/utils/customcolor.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit? imageFit;
  final double? borderraduis;
  const NetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.imageWidth,
    this.imageHeight,
    this.imageFit,
   this.borderraduis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderraduis ?? 10),
      child: CachedNetworkImage(
        width: imageWidth,
        height: imageHeight,
        imageUrl: imageUrl,
        fit: imageFit ?? BoxFit.fitWidth,

        placeholder: (context, url) => SpinKitThreeBounce(
          color: btncolor,
          size: 15.0,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red),
      ),
    );
  }
}
