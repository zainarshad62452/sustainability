class PowerModelJson {
  String? buildings,id,year;
  String? consumptionInKWh;
  String? the0;
  String? the1;
  String? the2;
  String? the3;
  String? the4;
  String? the5;
  String? the6;
  String? the7;
  String? the8;
  String? the9;
  String? the10;
  String? the11;
  String? the12;
  String? the13;
  String? the14;
  String? the15;
  String? the16;

  PowerModelJson({
     this.buildings,
     this.consumptionInKWh,
    this.the0,
    this.id,
    this.year,
     this.the1,
     this.the2,
     this.the3,
     this.the4,
     this.the5,
     this.the6,
     this.the7,
     this.the8,
     this.the9,
     this.the10,
     this.the11,
     this.the12,
     this.the13,
     this.the14,
     this.the15,
     this.the16,
  });

  PowerModelJson.fromJson(Map<String,dynamic> json){
    buildings = json["Buildings"].toString();
    consumptionInKWh = json["Consumption (In KWh)"].toString();
    the0 = json[""].toString();
    the1 = json["__1"].toString();
    the2 = json["__2"].toString();
    the3 = json["__3"].toString();
    the4 = json["__4"].toString();
   the5 =  json["__5"].toString();
    the6 = json["__6"].toString();
    the7 = json["__7"].toString();
    the8 = json["__8"].toString();
    the9 = json["__9"].toString();
    the10 = json["__10"].toString();
    the11 = json["__11"].toString();
    the12 = json["__12"].toString();
    the13= json["__13"].toString();
    the14 = json["__14"].toString();
    the15 = json["__15"].toString();
    the16 = json["__16"].toString();
  }
  Map<String, dynamic> toJson() =>{
    'id': id.toString(),
    'year': year.toString(),
    'houseNo': buildings.toString(),
    'totalPowerConsp': the11.toString(),
    'consumpInKitchen': "",
    'acConsmp': "",
    'totalAmount': "",
    'powerConsumption': [
      consumptionInKWh.toString(),
  the0.toString(),the1.toString(),the2.toString(),the3.toString(),the4.toString(),the5.toString(),the6.toString(),the7.toString(),the8.toString(),the9.toString(),the10.toString()
  ],
    'dates': [
      "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"
    ],
  };

}

enum ConsumptionInKWhEnum {
  CONSUMPTION_IN_K_WH,
  JAN
}

enum Enum {
  EMPTY,
  FEB
}

enum The1Enum {
  EMPTY,
  MAR
}

enum The10Enum {
  DEC,
  EMPTY
}

enum The11Enum {
  EMPTY,
  TOTAL,
  TOTAL_BUILDING
}

enum The12Enum {
  AVERAGE_A_SERIES,
  AVERAGE_D_SERIES,
  AVERAGE_F_SERIES,
  AVERAGE_I_SERIES,
  EMPTY
}

enum The13Enum {
  AVERAGE_B_SERIES,
  AVERAGE_E1_IT,
  AVERAGE_G_SERIES,
  EMPTY
}

enum The14Enum {
  AVERAGE_C_SERIES,
  AVERAGE_E2_E7,
  AVERAGE_H_SERIES,
  EMPTY
}

enum The16Enum {
  AVERAGE_OF_ALL_BUILDINGS_SERIESES,
  EMPTY
}

enum The2Enum {
  APR,
  EMPTY
}

enum The3Enum {
  EMPTY,
  MAY
}

enum The4Enum {
  EMPTY,
  JUN
}

enum The5Enum {
  EMPTY,
  JUL
}

enum The6Enum {
  AUG,
  EMPTY
}

enum The7Enum {
  EMPTY,
  SEP
}

enum The8Enum {
  EMPTY,
  OCT
}

enum The9Enum {
  EMPTY,
  NOV
}
