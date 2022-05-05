import 'package:flutter/material.dart';
import 'package:the_middlemen_garage/model/user_model.dart';
import 'package:the_middlemen_garage/pages/details.dart';

class CarItem extends StatefulWidget {
  final VehicleUser carDetails;

  const CarItem({Key? key, required this.carDetails}) : super(key: key);
  @override
  _CarItemState createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: <Widget>[
             (widget.carDetails.vehicleImg.isNotEmpty) ?

              Image.network(widget.carDetails.vehicleImg[0])
            : Icon(Icons.image),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      widget.carDetails.modelName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                  icon: Icon(Icons.arrow_forward, size: 20),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => details(
                          carDetails: widget.carDetails,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
