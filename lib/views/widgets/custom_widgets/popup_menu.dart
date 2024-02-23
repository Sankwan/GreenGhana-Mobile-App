import 'package:flutter/material.dart';

class CustomPopUpMenu extends StatelessWidget {
  final List<CustomPopUpItem> popupMenuItem;
  final Function(dynamic)? onSelected;

  const CustomPopUpMenu({
    Key? key,
    required this.popupMenuItem,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => popupMenuItem.map((item) {
        return PopupMenuItem<int>(
          value: item.value,
          child: Row(
            children: [
              Icon(item.icon),
              SizedBox(width: 10),
              Text(item.text),
            ],
          ),
        );
      }).toList(),
      onSelected: onSelected as void Function(int)?,
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}

class CustomPopUpItem {
  final IconData icon;
  final String text;
  final int value;

  CustomPopUpItem({
    required this.icon,
    required this.text,
    required this.value,
  });
}
