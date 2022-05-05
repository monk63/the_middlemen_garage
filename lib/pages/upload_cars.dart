import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_middlemen_garage/Components/firebase_services.dart';
import 'package:the_middlemen_garage/Components/validation_services.dart';
import 'package:the_middlemen_garage/model/user_model.dart';
import 'package:the_middlemen_garage/widgets/widgets.dart';

class uploadCars extends StatefulWidget {
  final VehicleUser? edit;
  const uploadCars({Key? key, this.edit}) : super(key: key);

  @override
  State<uploadCars> createState() => _uploadCarsState();
}

class _uploadCarsState extends State<uploadCars> {
  final _formKey = GlobalKey<FormState>();

  //values from text field
  TextEditingController _modelNameController = TextEditingController();
  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _amount = TextEditingController();

  List<File> files = [];

  //fecting the file
  Future<void> _pickImage() async {
    final List<XFile> selected = await ImagePicker().pickMultiImage() ?? [];
    if (selected.isNotEmpty) {
      setState(() {
        files.addAll(List.generate(
            selected.length, (index) => File(selected[index].path)));
      });
    }
  }

  FirebaseCloud firebaseCloud = FirebaseCloud();

  void _clear() {
    setState(() {
      files = [];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit != null) {
      _modelNameController.text = widget.edit!.modelName;
      _vehicleNumberController.text = widget.edit!.vehicleNumber;
      _ownerNameController.text = widget.edit!.ownerName;
      _colorController.text = widget.edit!.color;
      _phoneNumber.text = widget.edit!.phoneNumber;
      _amount.text = widget.edit!.amount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Builder(
        builder: (context) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomBackButton(pageHeader: 'Upload your car'),
                    SizedBox(
                      height: 20,
                    ),
                    files.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                child: ListView.builder(
                                    itemCount: files.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                20,
                                            child: Image.file(
                                              files[index],
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        )),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.refresh),
                                    onPressed: _clear,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.directions_car,
                                    size: 80,
                                  ),
                                  Text(
                                    'Choose your car image',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Model Name'),
                      obscureText: false,
                      validator: ValidationService().modelNameValidator,
                      controller: _modelNameController,
                    ),
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Vechile NUmber'),
                      obscureText: false,
                      validator: ValidationService().vehicleNumberValidator,
                      controller: _vehicleNumberController,
                    ),
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Owner Name'),
                      obscureText: false,
                      validator: ValidationService().ownerNameValidator,
                      controller: _ownerNameController,
                    ),
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Car Color'),
                      obscureText: false,
                      validator: ValidationService().colorValidator,
                      controller: _colorController,
                    ),
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Phone Number'),
                      obscureText: false,
                      validator: ValidationService().phoneNumberValidator,
                      controller: _phoneNumber,
                    ),
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Price'),
                      obscureText: false,
                      controller: _amount,
                    ),
                    SizedBox(
                      height: 0.05 * deviceSize.height,
                    ),
                    GestureDetector(
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Upload in progress'),
                          ),
                        );
                        VehicleUser owner = VehicleUser(
                          modelName: _modelNameController.text,
                          vehicleNumber: _vehicleNumberController.text,
                          ownerName: _ownerNameController.text,
                          color: _colorController.text,
                          vehicleImg: [],
                          ownerId: FirebaseAuth.instance.currentUser!.uid,
                          phoneNumber: _phoneNumber.text,
                          amount: double.parse(_amount.text),
                        );
                        //uploading to firebase then redirect
                        bool isComplete = false;
                        if (widget.edit == null) {
                          isComplete = await firebaseCloud.uploadVehicleInfo(
                              owner.toMap(), files, context);
                        } else {
                          isComplete = await firebaseCloud.editVehicleInfo(
                              owner.toMap(), files, context);
                        }
                        if (isComplete) {
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Upload failed')));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return uploadCars();
                              },
                            ),
                          );
                        }
                      },
                      child: CustomButton(
                        text: 'Upload',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
