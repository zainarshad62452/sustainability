class SeriesModel {
  String? series,averagePowerConsp;

  SeriesModel({
    this.averagePowerConsp,
    this.series
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
    averagePowerConsp: json['averagePowerConsp'].toString(),
    series: json['series'].toString(),
  );

  Map<String, dynamic> toJson() => {
    'averagePowerConsp': averagePowerConsp,
    'series': series,
  };
}
