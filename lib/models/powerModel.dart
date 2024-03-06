class PowerModel {
  String? id, year, totalPowerConsp, consumpInKitchen, acConsmp, totalAmount,houseNo;
  List<double>? powerConsumption;
  List<String>? dates;

  PowerModel({
    this.id,
    this.year,
    this.totalPowerConsp,
    this.consumpInKitchen,
    this.acConsmp,
    this.totalAmount,
    this.powerConsumption,
    this.dates,
    this.houseNo
  });

  factory PowerModel.fromJson(Map<String, dynamic> json) => PowerModel(
    id: json['id'],
    year: json['year'],
    totalPowerConsp: json['totalPowerConsp'],
    consumpInKitchen: json['consumpInKitchen'],
    acConsmp: json['acConsmp'],
    totalAmount: json['totalAmount'],
    houseNo: json['houseNo'],
    powerConsumption: (json['powerConsumption'] as List<dynamic>?)
        ?.map((e) => double.parse(e.toString()))
        .toList(),
    dates: (json['dates'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'year': year,
    'houseNo': houseNo,
    'totalPowerConsp': totalPowerConsp,
    'consumpInKitchen': consumpInKitchen,
    'acConsmp': acConsmp,
    'totalAmount': totalAmount,
    'powerConsumption': powerConsumption,
    'dates': dates,
  };
}
