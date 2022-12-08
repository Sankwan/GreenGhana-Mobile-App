import 'package:flutter/material.dart';

class PlantList {
  String title;
  String image;
  String description;
  Color color;

  PlantList({
    required this.title,
    required this.image,
    required this.description,
    required this.color,
  });
}

List<PlantList> lists = [
  PlantList(title: '', image: '', description: '', color: Colors.grey),
  PlantList(title: '', image: '', description: '', color: Colors.blue),
];
 


class ItemCard extends StatelessWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(40),
            height: 180,
            width: 160,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(16)),
            child: Image(image: AssetImage('assets/images/teak1.jpg')),
          ),
          Text('data'),
          Text('dataaaaa'),
          Container(
            padding: EdgeInsets.all(40),
            height: 180,
            width: 160,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(16)),
            child: Image(image: AssetImage('assets/images/teak.jpg')),
          ),
      ],
    );
  }
}