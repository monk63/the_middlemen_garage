import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:the_middlemen_garage/model/user_model.dart';

class FirebaseCloud {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<String> uploadUserData(Map<String, dynamic> data) async {
    String isUploaded = "";

    User? currentUser = FirebaseAuth.instance.currentUser;

    await collectionReference
        .doc(currentUser?.uid)
        .set(data)
        .then((_) => isUploaded = 'true')
        .catchError((e) => isUploaded = e.message);

    return isUploaded;
  }

  // Get data from firestore
  final uid = FirebaseAuth.instance.currentUser?.uid;

  Future<UserModel?> getUser() async {
    final userDoc = await collectionReference.doc(uid).get();

    if (userDoc.exists) {
      final userData = userDoc.data();
      final decodedData = UserModel.fromMap(userData);
      return decodedData;
    }
  }

  //upload image
  Future<bool> uploadVehicleInfo(Map<String, dynamic> data,
      List<File> localFile, BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    User currentUser = FirebaseAuth.instance.currentUser!;
    final Reference ref = storage.ref(currentUser.uid).child("images/");
    List<UploadTask> futures = [];
    for (File file in localFile) {
      futures.add(ref
          .child(DateTime.now().microsecondsSinceEpoch.toString())
          .putFile(file));
    }

    List<TaskSnapshot> imageResults = await Future.wait(futures);

    print("data one $data");
    List<String> image = [];

    for (TaskSnapshot path in imageResults) {
      String string = await path.ref.getDownloadURL();
      image.add(string);
    }
    data["vehicleImg"] = image;

    print("data two $data");
    await FirebaseFirestore.instance.collection('cars').doc().set(data);

    return true;
  }

  Future<bool> editVehicleInfo(Map<String, dynamic> data, List<File> localFile,
      BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    User currentUser = FirebaseAuth.instance.currentUser!;
    final Reference ref = storage.ref(currentUser.uid).child("images/");
    List<UploadTask> futures = [];
    for (File file in localFile) {
      futures.add(ref
          .child(DateTime.now().microsecondsSinceEpoch.toString())
          .putFile(file));
    }

    List<TaskSnapshot> imageResults = await Future.wait(futures);

    print("data one $data");
    List<String> image = [];

    for (TaskSnapshot path in imageResults) {
      String string = await path.ref.getDownloadURL();
      image.add(string);
    }
    data["vehicleImg"] = image;

    print("data two $data");
    QuerySnapshot<Map<String, dynamic>> reference = await FirebaseFirestore
        .instance
        .collection("cars")
        .where("vehicleNumber", isEqualTo: data["vehicleNumber"])
        .get();
    await reference.docs.first.reference.update(data);

    return true;
  }
}
