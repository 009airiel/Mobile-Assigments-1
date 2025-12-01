import 'package:flutter/material.dart';

class OceanCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const OceanCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(padding: padding, child: child),
    );
  }
}
