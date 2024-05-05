import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  const EmptyScreen({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
