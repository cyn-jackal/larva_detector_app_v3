import 'dart:ffi';

import 'package:flutter/material.dart';

class MySecoundButton extends StatelessWidget {
  final String? text;
  final double? height;
  final void Function()? onTap;
  const MySecoundButton({super.key,this.height, this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        padding: EdgeInsets.all(height != null ? 0 : 25),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white70)),
        child: Center(
          child: Text(
            text ?? "Clear",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
