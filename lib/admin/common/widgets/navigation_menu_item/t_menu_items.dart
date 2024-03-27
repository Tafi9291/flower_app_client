import 'package:t_store/admin/navigation_menu.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class TMenuItems extends StatelessWidget {
  const TMenuItems({
    super.key,
    required this.controller,
    required this.title, 
    required this.icon, 
    required this.index,
  });

  final NavigationAdminController controller;
  final String title;
  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: controller.selectedIndex.value == index ? TColors.primary.withOpacity(0.3) : null,
      leading: Obx(() => Icon(icon, color: controller.selectedIndex.value == index ? TColors.darkPrimary : Colors.black,)),
      title: Obx(() => Text(title, style: TextStyle(fontSize: 16 ,color: controller.selectedIndex.value == index ? TColors.darkPrimary : Colors.black),)),
      onTap: () {
        controller.selectedIndex.value = index;
        Navigator.pop(context);
      },
    );
  }
}