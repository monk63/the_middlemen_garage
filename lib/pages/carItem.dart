import 'dart:math';
import 'package:flutter/material.dart';
import 'package:the_middlemen_garage/model/user_model.dart';
import 'package:the_middlemen_garage/pages/details.dart';

class CarItem extends StatefulWidget {
  final VehicleUser carDetails;


const CarItem(
  {Key? key, required this.carDetails}) : super(key: key);
  @override
  _CarItemState createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Image.network(widget.carDetails.vehicleImg[0]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '\$' + widget.carDetails.amount.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    widget.carDetails.modelName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                     widget.carDetails.modelName.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Car brand',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              IconButton(
                                
                                 icon: Icon(Icons.arrow_forward,size: 20), onPressed: () { 
                                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => details(
                             carDetails: widget.carDetails,
                          )
                        )
                      );
                                  },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
      


    );


    // return GestureDetector(
    //   onTap: widget.press,
    //   child: Stack(
    //     overflow: Overflow.visible,
    //     children: <Widget>[
    //       Container(
    //         height: 280,
    //         width: 215,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(23),
    //           color: Colors.amberAccent
    //           // gradient: LinearGradient(
    //           //   begin: Alignment.topLeft,
    //           //   end: Alignment.bottomLeft,
    //           //   colors: [widget.carDetails.fColor,widget.carDetails.sColor],
    //           // )
    //         ),
    //       ),
    //       Positioned(
    //         child: Padding(
    //           padding: EdgeInsets.all(16),
    //           child: RichText(
    //             text: TextSpan(
    //               children: [
    //                 TextSpan(
    //                   text: 'Benz',
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 22,
    //                     color: Colors.white,
    //                   )
    //                 ),
    //                 TextSpan(
    //                     text: '\nBenz c300',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       letterSpacing: 1.1
    //                     )
    //                 ),
    //               ]
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //           top: 70,
    //           left: 16/20,
    //           child: Hero(
    //             tag: Random().nextInt(1000000),
    //             // tag: 'widget.carDetails.id',
    //             child: Placeholder(fallbackHeight: 220),
    //             // child: Image.asset('assets/images/splash.png'),
    //             // child: Image.asset('{widget.carDetails.imageUrl}',width: 220,),
    //           )
    //       ),
    //       Positioned(
    //         top: 150,
    //         child: Padding(
    //           padding: EdgeInsets.all(16),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               RichText(
    //                   text: TextSpan(
    //                     children: [
    //                       TextSpan(
    //                         text: 'Per Day\n',
    //                         style: TextStyle(
    //                           color: Colors.white70
    //                         ),
    //                       ),
    //                       TextSpan(
    //                         text: '\${widget.carDetails.price}',
    //                         style: TextStyle(
    //                             color: Colors.white70,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 25,
    //                           letterSpacing: 1.1,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //               ),
    //               SizedBox(height: 5,),
    //               Text(
    //                 'View Details',
    //                 style: TextStyle(
    //                   color: Colors.white70,
    //                   letterSpacing: 1.1,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}