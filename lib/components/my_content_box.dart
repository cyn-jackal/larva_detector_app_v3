import 'package:flutter/material.dart';

class MyContentBox extends StatelessWidget {
  final child;
  final double height;
  const MyContentBox({super.key,required this.child,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child
    );
  }
}