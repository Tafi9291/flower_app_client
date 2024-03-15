import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/sizes.dart';


class TOrderTitlePart extends StatelessWidget {
  const TOrderTitlePart({
    super.key,
    required this.title,
    this.icon,
    this.spacing = TSizes.spaceBtwItems,
  });

  final String title;
  final Icon? icon;
  final  double? spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Address
        if (icon != null) icon!,
        SizedBox(width: spacing),
        TSectionHeading(title: title, showActionButton: false),
      ],
    );
  }
}