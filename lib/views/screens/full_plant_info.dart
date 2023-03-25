import 'package:flutter/material.dart';
//working
class FullPlantingInfo extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  const FullPlantingInfo(
      {Key? key, required this.image, required this.title, required this.description})
      : super(key: key);

  @override
  State<FullPlantingInfo> createState() => _FullPlantingInfoState();
}

class _FullPlantingInfoState extends State<FullPlantingInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        children: [
          Container(
            height: 250,
            decoration:
                BoxDecoration(image: DecorationImage(image: NetworkImage(widget.image),fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 20,
          ),
          Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center,),
          SizedBox(
            height: 20,
          ),
          Text(widget.description)
        ],
      ),
    );
  }
}
