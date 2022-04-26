import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


import '../Components/app_title.dart';
import '../Components/constants.dart';



class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _launchUrl(String _url) async {
      await canLaunch(_url)
          ? await launch(_url)
          : throw 'Could not launch $_url';
    }

    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          ),
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          )
        ],
        title: const AppBarTitle(
          leadingTitle: 'About',
          trailingTitle: 'Us',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            SizedBox(
                height: 150,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/splash.png"),
                  radius: 70.0,
                ),
              ),
            const SizedBox(
              height: 8,
            ),
            const AppBarTitle(
              trailingTitle: 'Middlemen Garage',
              fontSize: 36,
            ),
            const AppBarTitle(
              leadingTitle: 'by',
              fontSize: 16,
            ),
            const AppBarTitle(
              leadingTitle: 'Michael ',
              trailingTitle: 'Ofori',
              fontSize: 20,
            ),
            const SizedBox(
              height: 48,
            ),
            const Spacer(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _launchUrl(fbUrl),
                  icon: const Icon(
                    CarbonIcons.logo_facebook,
                    size: 32,
                  ),
                ),
                IconButton(
                  onPressed: () => _launchUrl(mailUrl),
                  icon: const Icon(
                    CarbonIcons.email,
                    size: 32,
                  ),
                ),
                IconButton(
                  onPressed: () => _launchUrl(githubUrl),
                  icon: const Icon(
                    CarbonIcons.logo_github,
                    size: 32,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
