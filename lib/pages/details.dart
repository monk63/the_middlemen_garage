import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
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
                        text: '\c ' + widget.carDetails.amount.toString(),
                        helpText: 'Car Price',
                      ),
                      SpecificationWidget(
                        text: widget.carDetails.vehicleNumber.toString(),
                        helpText: 'Vin',
                      ),
                      // SpecificationWidget(
                      //   text: '₹ ' +
                      //       (widget.rideCost +
                      //               (int.parse(widget.docSnapshot.data.amount)))
                      //           .toString(),
                      //   helpText: 'Total cost',
                      // ),
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
                        text: 'Quick Sale',
                        helpText: 'Avaliability',
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
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.delete)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => uploadCars(
                                        edit: widget.carDetails,
                                      ),
                                    ),
                                  );
                                  setState(() {});
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
