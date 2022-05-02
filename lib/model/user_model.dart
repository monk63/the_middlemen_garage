class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

  UserModel({this.uid, this.email, this.firstName, this.secondName});

  // Receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  // Sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}

class VehicleUser {
  String modelName;
  String vehicleNumber;
  String ownerName;
  String color;
  String vehicleImg;
  String phoneNumber;
  bool hasCompletedRegistration = false;
  double amount;
  String ownerEmail;

  VehicleUser({
    required this.modelName,
    required this.vehicleNumber,
    required this.ownerName,
    required this.color,
    required this.vehicleImg,
    required this.phoneNumber,
    this.hasCompletedRegistration = false,
    required this.amount,
    required this.ownerEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'modelName': modelName,
      'vehicleNumber': vehicleNumber,
      'ownerName': ownerName,
      'color': color,
      'vehicleImg' : vehicleImg,
      'aadharNumber': phoneNumber,
      'hasCompletedRegistration': hasCompletedRegistration,
      'amount': amount,
      'ownerEmail': ownerEmail
    };
  }

  factory VehicleUser.fromMap(Map<String, dynamic> data) {
    return VehicleUser(
      modelName: data["modelName"], 
      vehicleNumber: data["vehicleNumber"],
       ownerName: data["ownerName"], 
       color: data["color"], 
       vehicleImg: data["vehicleImg"],
        phoneNumber: data["phoneNUmber"],
         amount: data["amount"],
          ownerEmail: data["ownerEmail"]
          );
  }
}