import 'package:flutter/material.dart';

class TNotiTitleText extends StatelessWidget {
  const TNotiTitleText({
    super.key, 
    required this.title,
    this.smallSize = false, 
    this.maxLine = 2, 
    this.textAlign = TextAlign.left,

  });

  final String title;
  final bool smallSize;
  final int maxLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize ? Theme.of(context).textTheme.labelLarge : Theme.of(context).textTheme.titleLarge,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
      textAlign: textAlign,

    );
  }
}