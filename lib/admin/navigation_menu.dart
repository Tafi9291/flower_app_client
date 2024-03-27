import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/admin/common/widgets/images/t_circular_image.dart';
import 'package:t_store/admin/common/widgets/navigation_menu_item/t_menu_items.dart';
import 'package:t_store/admin/featured/account/account.dart';
import 'package:t_store/admin/featured/category/category.dart';
import 'package:t_store/admin/featured/home/home.dart';
import 'package:t_store/admin/featured/orders/order.dart';
import 'package:t_store/admin/featured/products/product.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationAdminMenu extends StatefulWidget {
  const NavigationAdminMenu({super.key});

  @override
  State<NavigationAdminMenu> createState() => _NavigationAdminMenuState();
}

class _NavigationAdminMenuState extends State<NavigationAdminMenu> {

  AuthUserApiHandler adminApiHandler = AuthUserApiHandler();

  Map<String, dynamic> adminDetail = {};

  @override
  void initState() {
    super.initState();
    loadAdminDetail();
  }

  void loadAdminDetail() async {
    try {
      final adminDetailResponse = await adminApiHandler.getUserDetail();
      setState(() {
        adminDetail = adminDetailResponse;
      });
    } catch (e) {
      print('Failed to load admin detail: $e');
    }
  }
  

  void logout() async {
    await adminApiHandler.logout();
    // Sau khi đăng xuất, bạn có thể điều hướng người dùng đến màn hình đăng nhập hoặc màn hình khác tùy thuộc vào luồng ứng dụng của bạn
    Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationAdminController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: darkMode ? TColors.black : TColors.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TCircularImage(image: TImages.user, width: 60, height: 60, padding: 0,),
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                          Text('${adminDetail['firstName']} ${adminDetail['lastName']}', style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.dark)),
                          Text('${adminDetail['email']}', style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.dark)),
                        ],
                      ),
                    ),
                  ),
                  TMenuItems(controller: controller, title: 'Trang chủ', icon: Iconsax.home, index: 0),
                  TMenuItems(controller: controller, title: 'Phân loại sản phẩm', icon: Icons.category_outlined, index: 1),
                  TMenuItems(controller: controller, title: 'Sản phẩm', icon: Icons.add_box_outlined, index: 2),
                  TMenuItems(controller: controller, title: 'Đơn hàng', icon: Iconsax.box, index: 3),
                  TMenuItems(controller: controller, title: 'Tài khoản', icon: Iconsax.user, index: 4),
                  
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Iconsax.logout),
              title: const Text('Đăng xuất', style: TextStyle(fontSize: 16),),
              onTap: logout,
            ),
            const SizedBox(height: 15,)
                  
          ],
        ),
      ),
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
            NavigationDestination(icon: Icon(Icons.category_outlined), label: 'Phân loại',),
            NavigationDestination(icon: Icon(Icons.add_box_outlined), label: 'Sản phẩm',),
            NavigationDestination(icon: Icon(Iconsax.box), label: 'Đơn hàng',),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Tài khoản',),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}




class NavigationAdminController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [const HomeScreen(), const CategoryScreen(), const ProductScreen(), const OrderScreen(), const AccountScreen()];
  // final screens = [const HomeScreen(), const FavouriteScreen(), const SettingScreen(),];
}