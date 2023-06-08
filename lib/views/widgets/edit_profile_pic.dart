import 'package:flutter/material.dart';

class ProfilePic extends StatefulWidget {
  final String imgUrl;
  const ProfilePic({super.key, required this.imgUrl});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 4, color: Theme.of(context).scaffoldBackgroundColor),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 10))
              ],
              shape: BoxShape.circle,
              //how to make users profile image appear here by default and then change after edit is done
              image: widget.imgUrl.isEmpty? DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/default_image.jpg')) : 
                DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.imgUrl)) ,
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: Colors.green,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
