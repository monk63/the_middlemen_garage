import 'package:flutter/material.dart';
import '../Components/app_title.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? headline6 = Theme.of(context).textTheme.headline6;
    TextStyle? bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 182, 58, 58),
        title: const AppBarTitle(
          leadingTitle: 'FAQs',
        ),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How to add a car',
                style: headline6,
              ),
              Text(
                'Go to the side drawer and click upload car. Then tap on the car icon to upload a picture of the car from the device. Fill in the other fields and click upload.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How to view a car',
                style: headline6,
              ),
              Text(
                'Tap on the arrow button on the right corner to view the specifications of the car.',
                style: bodyText1,
              ),
               const Divider(height: 16),
              Text(
                'How to edit',
                style: headline6,
              ),
              Text(
                'On the details screen, press the edit icon. Click the car icon to upload a new image and fill in the desired details and submit. ',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How delete car',
                style: headline6,
              ),
              Text(
                'On the details screen, press the delete icon.The car would be deleted',
                style: bodyText1,
              ),
              const Divider(height: 16),
               const Divider(height: 16),
              Text(
                'How buy a car',
                style: headline6,
              ),
              Text(
                'On the details screen, press the contact icon to contact the seller.',
                style: bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
