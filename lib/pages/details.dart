import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_middlemen_garage/Components/firebase_services.dart';
import 'package:the_middlemen_garage/model/user_model.dart';
import 'package:the_middlemen_garage/pages/upload_cars.dart';
import 'package:the_middlemen_garage/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class details extends StatefulWidget {
  const details({Key? key, required this.carDetails}) : super(key: key);

  final VehicleUser carDetails;

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  FirebaseCloud firebaseCloud = FirebaseCloud();

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().initialize(
      'resource://drawable/splash',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: Color.fromARGB(255, 202, 112, 9),
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: '',
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(235, 235, 240, 1),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(
                      pageHeader: '',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.carDetails.modelName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      widget.carDetails.ownerName.toUpperCase(),
                      style: TextStyle(
                        color: Color.fromRGBO(27, 34, 46, 1),
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.network(
                      widget.carDetails.vehicleImg[0],
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SPECIFICATIONS',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpecificationWidget(
                        text: '\$ ' + widget.carDetails.amount.toString(),
                        helpText: 'Car Price',
                      ),
                      SpecificationWidget(
                        text: widget.carDetails.vehicleNumber.toString(),
                        helpText: 'Vin',
                      ),
                      SpecificationWidget(
                        text: 'Quick Sale',
                        helpText: 'Avaliability',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpecificationWidget(
                        text: widget.carDetails.color.toString(),
                        helpText: "Car's Color",
                      ),
                      SpecificationWidget(
                        text: 'Accra',
                        helpText: 'Location',
                      ),
                      SpecificationWidget(
                        text: widget.carDetails.phoneNumber,
                        helpText: 'Contact',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: FirebaseAuth.instance.currentUser!.uid !=
                          widget.carDetails.ownerId
                      ? []
                      : [
                          //Delete
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  Widget cancelButton = TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                  );
                                  Widget continueButton = TextButton(
                                    child:
                                        const Text("Yes, Delete Car Forever"),
                                    onPressed: () async {
                                      await firebaseCloud.deleteVehicleInfo(
                                          context, widget.carDetails.toMap());
                                      setState(() {});
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                      Fluttertoast.showToast(
                                          msg: "Car Deleted",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Color.fromARGB(255, 95, 55, 43),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    },
                                  );
                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: const Text(
                                        "Confirm Permanent Deletion"),
                                    content: const Text(
                                        "You are about to perform an action that cannot be undone..."),
                                    actions: [
                                      cancelButton,
                                      continueButton,
                                    ],
                                  );
                                  // show the dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                              )),
                          //Edit button
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => uploadCars(
                                        edit: widget.carDetails,
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                  await AwesomeNotifications()
                                      .createNotification(
                                    content: NotificationContent(
                                        id: 10,
                                        channelKey: 'basic_channel',
                                        title: 'Do It',
                                        body:
                                            'Your task has been created successfully'),
                                  );
                                },
                                icon: Icon(Icons.edit)),
                          ),
                        ]),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  try {
                    launchUrl(
                        Uri.parse("tel:${widget.carDetails.phoneNumber}"));
                  } catch (e) {
                    print("");
                  }
                },
                child: CustomButton(
                  text: 'Contact',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecificationWidget extends StatelessWidget {
  final String helpText;
  final String text;

  SpecificationWidget({required this.text, required this.helpText});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              helpText,
              style: TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}
