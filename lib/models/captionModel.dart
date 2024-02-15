class CaptionModel{

  String? captionText,uid,uploadedBy;
  DateTime? date;

  CaptionModel({
    this.uid,
    this.date,
    this.captionText,
    this.uploadedBy
  });
  CaptionModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    captionText = json['imageUrl'];
    uploadedBy = json['uploadedBy'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['imageUrl'] = this.captionText;
    data['uploadedBy'] = this.uploadedBy;
    data['uid'] = this.uid;
    return data;
  }

}