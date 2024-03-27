import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/device/device_utility.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,

    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false, 
    this.backgroundColor = const Color.fromARGB(255, 184, 235, 175),
  });

  final Widget? title;
  final bool showBackArrow;
  final Color? backgroundColor;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
      padding: EdgeInsets.zero,
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow 
            ? IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left)) 
            : leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon), style: IconButton.styleFrom(iconSize: 36)) : null,
        title: title,
        actions: actions,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}