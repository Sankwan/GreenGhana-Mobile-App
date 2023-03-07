import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About instagram_aa'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            height: 300,
            width: 300,
            child: Image.asset('assets/images/greenghanalogo.png'),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 20, top: 20),
            child: Text(
              ' Ghana has been losing rainforest at an alarming rate in recent years, but the government of Ghana is taking steps to change all that. \n This app is to make good enough public awareness on the lengths to which the instagram_aa Day is going. \n ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextButton(
              onPressed: () async {
                final url = 'https://greenghana.mlnr.gov.gh';

                openBrowserURL(
                  url: url,
                  inApp: true,
                );
              },
              child: const Text(
                'Tap for more information on the instagram_aa Project',
                style:
                    TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
              ))
        ],
      ),
    );
  }
}

//fix this page later on

//to open browser in app
Future openBrowserURL({
  required String url,
  bool inApp = false,
}) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: inApp,
      forceWebView: inApp,
      enableJavaScript: true,
    );
  }
}

// Future<void> CALL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw "cannot launch $url";
//   }
// }

// launchurl() async {
//   const url = 'https://www.youtube.com/channel/UCS3brcF49FE3japE2xM-8gg';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw "cannot launch $url";
//   }
// }

// launchEmail() async {
//   launch(
//     'mailto:cp277478@gmail.com?subject=TestEmail&body= Subscribe webfun please',
//   );
// }
