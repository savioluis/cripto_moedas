import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  final String text;
  final Icon? icon;
  final Function() onPressed;

  const FullWidthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.all(12),
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: onPressed,
        child: icon == null
            ? Text(text)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [icon!, const SizedBox(width: 10), Text(text)]),
      ),
    );
  }
}
