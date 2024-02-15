class ImagesModel{

  String? imageUrl,uid,uploadedBy;
  DateTime? date;

  ImagesModel({
   this.uid,
   this.date,
   this.imageUrl,
    this.uploadedBy
});
  ImagesModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    imageUrl = json['imageUrl'];
    uploadedBy = json['uploadedBy'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['imageUrl'] = this.imageUrl;
    data['uploadedBy'] = this.uploadedBy;
    data['uid'] = this.uid;
    return data;
  }

}