import 'package:flutter/material.dart';

class CustomSOSContactDisplay extends StatelessWidget {
  const CustomSOSContactDisplay({
    super.key,
    required this.contactName,
    required this.contactNumber,
    required this.email,
  });

  final String contactName;
  final String contactNumber;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(contactName, style: const TextStyle(fontSize: 16.0),),
            Text(contactNumber, style: const TextStyle(fontSize: 16.0),),
          ],
        ),
        const SizedBox(height: 2.0,),
        Text(email, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300)),
        const SizedBox(height: 12.0,),
      ],
    );
  }
}
