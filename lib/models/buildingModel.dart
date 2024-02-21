class BuildingModel {
  String? id,totalPowerConsp;

  BuildingModel({
    this.id,
    this.totalPowerConsp,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) => BuildingModel(
    id: json['id'],
    totalPowerConsp: json['totalPowerConsp'].toString(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'totalPowerConsp': totalPowerConsp,
  };
}
