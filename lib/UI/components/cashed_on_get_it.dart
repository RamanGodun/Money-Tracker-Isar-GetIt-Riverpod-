import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCashedWidgets1 {
  AppCashedWidgets1._internal();

  static final AppCashedWidgets1 _instance = AppCashedWidgets1._internal();

  factory AppCashedWidgets1() => _instance;

  final Widget _loadingWidget = _buildLoadingWidget();

  static Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
            radius: 15.0,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget get loadingWidget => _loadingWidget;

  Widget getCustomLoadingWidget({double? radius, Color? color}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
            radius: radius ?? 25.0,
            color: color ?? const Color.fromARGB(255, 143, 201, 122),
          ),
        ],
      ),
    );
  }
}
