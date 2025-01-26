import 'package:flutter/material.dart';

class MyPrimaryButton extends StatelessWidget {
  final String? text;
  final double? height;
  final void Function()? onTap;
  const MyPrimaryButton({super.key,this.height, this.text , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: EdgeInsets.all(height != null ? 0 : 25),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.amber[600], borderRadius: BorderRadius.circular(12)),
        child:  Center(
          child: Text(
            text ?? "Submit",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
