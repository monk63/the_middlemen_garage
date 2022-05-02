import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_middlemen_garage/Components/validation_services.dart';
import 'package:the_middlemen_garage/model/user_model.dart';
import 'package:the_middlemen_garage/pages/home.dart';
import 'package:the_middlemen_garage/widgets/widgets.dart';


class uploadCars extends StatefulWidget {
  const uploadCars({ Key? key }) : super(key: key);

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


  VehicleUser owner = VehicleUser();
  List<File> files=[];

  //fecting the file
   Future<void> _pickImage() async {
    final List<XFile>  selected = await ImagePicker().pickMultiImage() ?? [];
    if (selected.isNotEmpty){
      setState(() {
        files.addAll(List.generate(selected.length, (index) => File(selected[index].path)));
      });

    }
  }

 
  void _clear() {
    setState(() {
      files = [];
    });
  }

    void initVehicleUser() {
    owner.modelName = _modelNameController.text;
    owner.vehicleNumber = _vehicleNumberController.text;
    owner.ownerName = _ownerNameController.text;
    owner.color = _colorController.text;
    owner.phoneNumber = _phoneNumber.text;
    owner.hasCompletedRegistration = true;
    owner.amount = _amount.text;
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
                    CustomBackButton(pageHeader: 'Register your car'),
                    SizedBox(
                      height: 20,
                    ),
                    files.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  child: Image.file(
                                    files[0],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
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
                            SnackBar(content: Text('Processing')));
                        initVehicleUser();
                        String isComplete =
                            await firebaseFunctions.uploadVehicleInfo(
                                owner.toMap(), imageFile, context);
                        if (isComplete == 'true') {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(isComplete)));
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
                        text: 'Register',
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