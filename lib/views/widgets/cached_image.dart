import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/utils/progressloader.dart';
import 'package:shimmer/shimmer.dart';

class CustomCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final bool? circularShape;
  const CustomCacheImage(
      {Key? key,
      required this.imageUrl,
      required this.radius,
      this.circularShape})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(circularShape == false ? 0 : radius),
          bottomRight: Radius.circular(circularShape == false ? 0 : radius)),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        placeholder: (context, url) => imagePlaceholder(),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        ),
        // progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        //   child: Shimmer.fromColors(
        //     baseColor: const Color.fromARGB(255, 180, 180, 180),
        //     highlightColor: const Color.fromARGB(255, 209, 208, 208),
        //     child: Container(
        //       color: const Color.fromARGB(255, 255, 234, 234),
        //       height: double.infinity,
        //       width: double.infinity,
        //       child: Icon(
        //         Icons.image,
        //         color: const Color.fromARGB(255, 169, 74, 74),
        //         size: radius > 10 ? radius : 20,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
