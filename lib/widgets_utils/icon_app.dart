import 'package:datacar/config/data_car_image.dart';
import 'package:datacar/initial_page.dart';
import 'package:flutter/material.dart';

Widget iconApp({double? wid, double? hei}){
  return SizedBox(
    width: wid ?? sizeW,
    child: Container(
      height: hei ?? sizeH * 0.25,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset(DataCarImage.logoRemoveBg).image,
              fit: BoxFit.fitHeight
          )
      ),
    ),
  );
}