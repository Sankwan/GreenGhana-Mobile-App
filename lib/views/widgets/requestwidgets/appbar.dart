import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../glitch.dart';

class RequestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RequestAppBar({super.key});

  static final _appBar = AppBar();
  
  @override
  Size get preferredSize => _appBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        actions: [
          GlithEffect(
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Guide to Make a Request'),
                            content: Text(
                                'Making one Seedling Request:\n1. Select the type of Seedling\n2. Enter the number of Seedlings you want for the selected seedling\n3. Tap the Add Button below\n4. If you are okay with the request, select the location where you want to pick-up the seedling.\n5. Tap Submit\n\nMaking multiple requests:\n1. Follow steps 1 to 3 above\n2. After tapping the Add button, go back and repeat steps 1 to 3 to add additional seedlings to your requests.\n3. You can do this over and over before selecting a location.\nNote: After submitting your request in the end, you can\'t make another request'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Ok'))
                            ],
                          ));
                },
                icon: const Icon(
                  Icons.info,
                  color: Colors.green,
                )),
          )
        ],
        title: const Text(
          'Make a Seedling Request',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        elevation: .5,
      );
  }
}