import 'package:flutter/material.dart';

class SnackBarUtil {
  static infoSnackBar(BuildContext context, String text, {TextStyle? textStyle}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: textStyle ??
              const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
