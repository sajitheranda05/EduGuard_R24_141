import 'package:flutter/material.dart';

class CustomSOSTitleCard extends StatelessWidget {
  const CustomSOSTitleCard({
    super.key,
    required this.title,
    required this.subtitle
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        const SizedBox(height: 2.0,),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
        ),
        const Divider(),

        const SizedBox(height: 24.0,),
      ],
    );
  }
}
