import 'package:t_store/admin/featured/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';

class TNotiCounterIcon extends StatelessWidget {
  const TNotiCounterIcon({
    super.key, 
    this.iconColor = TColors.dark, 
    required this.onPressed,
  });

  final Color iconColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Stack(
        children: [
          SizedBox(width: 60,child: IconButton(onPressed: () => Get.to(() => const NotificationScreen()), icon: Icon(Iconsax.notification, color: iconColor,))),
          Positioned(
            right: 4,
            child: Container(
              constraints: const BoxConstraints.expand(height: 18, width: 20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  '10', 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis, 
                  style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}