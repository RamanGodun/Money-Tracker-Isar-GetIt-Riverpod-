import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// `AnimationService` is a simple service class that manages an `AnimationController`
/// to handle forward and reverse animations. It provides basic controls for starting
/// and reversing animations, as well as access to the animation object itself.
class AnimationService {
  /// The `AnimationController` that drives the animation.
  final AnimationController controller;

  /// Constructor for `AnimationService`, requiring an `AnimationController` to be passed.
  AnimationService({required this.controller});

  /// Starts the animation by calling the `forward` method on the controller.
  void forward() {
    controller.forward();
  }

  /// Reverses the animation by calling the `reverse` method on the controller.
  void reverse() {
    controller.reverse();
  }

  /// Provides direct access to the `Animation<double>` object driven by the controller.
  /// This allows external classes or widgets to listen to animation values.
  Animation<double> get animation => controller;
}
