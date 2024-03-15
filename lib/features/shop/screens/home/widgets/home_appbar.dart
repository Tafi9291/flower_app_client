import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17.0),
      child: TAppBar(title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.dark)),
            Text(TTexts.homeAppbarSubTitle, style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.dark)),
          ],
        ),
        actions: [
          TCartCounterIcon(onPressed: () {}, iconColor: Colors.black),
        ],
      ),
    );
  }
}