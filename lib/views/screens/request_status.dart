import 'package:flutter/material.dart';
import 'package:instagram_aa/views/screens/home/mainhomepage.dart';
import 'package:instagram_aa/views/screens/homepage.dart';
import 'package:instagram_aa/views/screens/planting_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//working
class RequestStatus extends StatelessWidget {
  const RequestStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/tick.png'))),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Request Successful !',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Report to your chosen location to receive seedlings from our Officers',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 250,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.extended(
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainHomepage()),
                      (route) => false,
                    );
                  },
                  icon: Icon(Icons.dashboard_rounded),
                  label: const Text('Return Home')),
              //the default back arrow on this page has to be fixed so that it
              //doesnt take us back to the seedling checkout page

              FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlantingInfo()));
                  },
                  icon: Icon(FontAwesomeIcons.tree),
                  label: const Text('Planting'))
            ],
          ),
        ],
      ),
    );
  }
}
