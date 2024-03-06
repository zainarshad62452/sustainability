class BuildingModel {
  String? id,totalPowerConsp,series,averagePowerConsp;

  BuildingModel({
    this.id,
    this.totalPowerConsp,
    this.series
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) => BuildingModel(
    id: json['id'],
    totalPowerConsp: json['totalPowerConsp'].toString(),
    series: json['series'].toString(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'totalPowerConsp': totalPowerConsp,
    'series': series,
  };
}
