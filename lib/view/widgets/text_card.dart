import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:just_play_test/constans/color_manager.dart';
import 'package:just_play_test/view/login_view/app_typography.dart';

class TextCard extends StatelessWidget {
  const TextCard({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.stRaleway(
          color: ColorManager.neutralWhite,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }
}
