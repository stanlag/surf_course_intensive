import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String titleText;
  final String paragraphText;
  const TextWidget({
    required this.titleText,
    required this.paragraphText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(titleText,
                style: GoogleFonts.yanoneKaffeesatz(fontSize: 20))),
        Text(
          paragraphText,
          style: GoogleFonts.caveat(fontSize: 20),
        ),
      ],
    );
  }
}
