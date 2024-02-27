import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    Key? key,
    this.radius = 10,
    this.imageUrl = "",
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
  }) : super(key: key);
  final double radius;
  final String imageUrl;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.hardEdge,
        child: CachedNetworkImage(
          memCacheHeight: 300,
          memCacheWidth: 350,
          imageUrl: imageUrl,
          fit: fit,
          // memCacheHeight: height?.toInt(),
          // memCacheWidth: MediaQuery.of(context).size.width.toInt(),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 180, 180, 180),
              highlightColor: const Color.fromARGB(255, 209, 208, 208),
              child: Container(
                color: const Color.fromARGB(255, 255, 234, 234),
                height: double.infinity,
                width: double.infinity,
                child: Icon(
                  Icons.image,
                  color: const Color.fromARGB(255, 169, 74, 74),
                  size: radius > 10 ? radius : 20,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) =>
              errorWidget ?? const Icon(Icons.error),
        ),
      ),
    );
  }
}
