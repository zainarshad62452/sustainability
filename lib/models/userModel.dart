import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  Timestamp? registeredOn;
  String? profileImageUrl;
  List<String>? uploadedImages;
  List<String>? uploadedCaptions;

  UserModel(
      {this.name,
        this.email,
        this.registeredOn,
        this.profileImageUrl,
        this.uploadedImages,
        this.uploadedCaptions,
        this.uid,
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    registeredOn = json['registeredOn'];
    profileImageUrl = json['profileImageUrl'];
    uploadedImages = json['uploadedImages'];
    uploadedCaptions = json['uploadedCaptions'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['registeredOn'] = this.registeredOn;
    data['profileImageUrl'] = this.profileImageUrl;
    data['uploadedImages'] = uploadedImages;
    data['uploadedCaptions'] = uploadedCaptions;
    data['uid'] = this.uid;
    return data;
  }
}
