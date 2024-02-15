import 'package:flutter/material.dart';

class BannerModel {
  String text;
  List<Color> cardBackground;
  String image;

  BannerModel(this.text, this.cardBackground, this.image);
}

List<BannerModel> bannerCards = [
  new BannerModel(
      "Prayer Timing",
      [
        Color(0xffa1d4ed),
        Color(0xffc0eaff),
      ],
      "assets/logo pic.png"),
  new BannerModel(
      "Mosques Details",
      [
        Color(0xffb6d4fa),
        Color(0xffcfe3fc),
      ],
      "assets/Ibadat.webp"),
];
