import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('images/earth.svg',
        width: 20,
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn));
  }
}
