import 'package:flutter/material.dart';

class GeneralDataModel {
  final Size deviceSize;
  final bool isFirstChart;
  final bool isPortraitMode;

  GeneralDataModel({
    required this.deviceSize,
    required this.isFirstChart,
    required this.isPortraitMode,
  });
}
