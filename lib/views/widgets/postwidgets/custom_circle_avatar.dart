import 'package:flutter/material.dart';
import 'image_loader.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String avatar;
  const CustomCircleAvatar({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: ImageLoader(
        imageUrl: avatar,
        radius: 30,
        errorWidget: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: avatar == ''
                    ? AssetImage('assets/images/default_image.jpg')
                        as ImageProvider
                    : NetworkImage(avatar),
              )),
            )),
      ),
    );
  }
}
