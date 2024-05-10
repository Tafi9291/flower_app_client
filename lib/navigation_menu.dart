import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/screens/settings/settings.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/features/shop/screens/notifications/notifications.dart';
// import 'package:t_store/features/shop/screens/store/store.dart';
import 'package:t_store/features/shop/screens/wishlist/wishlist.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode ? TColors.white.withOpacity(0.1) : TColors.primary.withOpacity(0.4),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Trang chủ',),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Yêu thích',),
            NavigationDestination(icon: Icon(Iconsax.notification), label: 'Thông báo',),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Tài khoản',),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}


class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [const HomeScreen(), const FavouriteScreen(), const NotificationsSrceen(), const SettingScreen(),];
  // final screens = [const HomeScreen(), const FavouriteScreen(), const SettingScreen(),];
}