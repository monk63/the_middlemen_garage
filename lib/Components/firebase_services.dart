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


   //upload image
  Future<bool> deleteVehicleInfo(BuildContext context,
  Map<String, dynamic> data) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    User currentUser = FirebaseAuth.instance.currentUser!;

    //getting image reference from url
    final Reference ref = storage.ref(currentUser.uid).child("images/");
    List<Future> futures = [];
    for (String url in data["vehicleImg"]) {
      // https://firebasestorage.googleapis.com/v0/b/the-garage-5676d.appspot.com/o/qhZ5NfC5cRMxREwT0vprmGJEDNA2%2Fimages%2F1651754590650977?alt=media&token=8516668c-a269-4c86-a4a0-ec99f6cd12e4

      String path = url.split("?")[0].split("%").last;
      print("path ${ref.child(path).fullPath}");
      futures.add(ref.child(path).delete());


      // futures.add(ref
      //     .child(url.split("pattern")))
      //     .putFile(file));
    }

//deleting images
    // await Future.wait(futures);

    print("data one $data");

    print("data two $data");

    //deleting file
    QuerySnapshot<Map<String, dynamic>> e = await FirebaseFirestore.instance.collection('cars').where("vehicleNumber", isEqualTo: data["vehicleNumber"]).limit(1).get();
    await e.docs.first.reference.delete();

    return true;
  }




}
