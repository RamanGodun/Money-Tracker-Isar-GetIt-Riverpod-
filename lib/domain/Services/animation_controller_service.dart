import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationService {
  final AnimationController controller;

  AnimationService({required this.controller});

  void forward() {
    controller.forward();
  }

  void reverse() {
    controller.reverse();
  }

  Animation<double> get animation => controller;
}
