import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageWithDarkFilterBottom extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final bool? circularShape;
  final bool? allPosition;
  const CustomImageWithDarkFilterBottom(
      {Key? key,
      required this.imageUrl,
      required this.radius,
      this.circularShape,
      this.allPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(circularShape == false ? 0 : radius),
          bottomRight: Radius.circular(circularShape == false ? 0 : radius)),
      child: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0x00000000).withOpacity(.2),
                  const Color(0x00000000).withOpacity(.2),
                  const Color(0x00000000).withOpacity(.5),
                  const Color(0xcc000000).withOpacity(.8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget imagePlaceholder() {
  return SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFF1F4F8)),
          alignment: const AlignmentDirectional(0, 0),
        )),
  );
}

Widget customNetworkImage(String imgUrl, BuildContext context) {
  return CachedNetworkImage(
    imageUrl: imgUrl,
    fit: BoxFit.cover,
    height: MediaQuery.of(context).size.height,
    placeholder: (context, url) => imagePlaceholder(),
    errorWidget: (context, url, error) => Container(
      color: Colors.grey[300],
      child: const Icon(Icons.error),
    ),
  );
}

class CustomImageFileWithDarkFilter extends StatelessWidget {
  final File file;
  final double radius;
  final bool? circularShape;
  final bool? allPosition;
  const CustomImageFileWithDarkFilter(
      {Key? key,
      required this.file,
      required this.radius,
      this.circularShape,
      this.allPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(circularShape == false ? 0 : radius),
          bottomRight: Radius.circular(circularShape == false ? 0 : radius)),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.file(
              file,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0x00000000).withOpacity(.2),
                  const Color(0x00000000).withOpacity(.2),
                  const Color(0x00000000).withOpacity(.2),
                  const Color(0xcc000000).withOpacity(.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
