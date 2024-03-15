import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:t_store/common/widgets/list_tiles/t_profile_tile.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/features/shop/screens/notifications/notifications.dart';
import 'package:t_store/features/shop/screens/order/order.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  TAppBar(title: Text('Tài khoản', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.dark))),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// User Profile Card
                  TUserProfileTile(onPressed: () => Get.to(()  => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Account Settings
                  const TSectionHeading(title: 'Cài đặt tài khoản', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// 
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home, 
                    title: 'Địa chỉ của tôi', 
                    subtitle: 'Hãy cho biết địa chỉ giao hàng', 
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart, 
                    title: 'Giỏ hàng của tôi', 
                    subtitle: 'Thêm, xóa sản phẩm và chuyển sang thanh toán',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick, 
                    title: 'Đơn hàng của tôi', 
                    subtitle: 'Đơn hàng đang thực hiện và đã hoàn thành',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  // const TSettingsMenuTile(
                  //   icon: Iconsax.bank, 
                  //   title: 'Tài khoản ngân hàng', 
                  //   subtitle: 'Withdraw balance to registered bank account',
                  // ),
                  const TSettingsMenuTile(
                    icon: Iconsax.discount_shape, 
                    title: 'Mã giảm giá', 
                    subtitle: 'Danh sách mã giảm giá',
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification, 
                    title: 'Thông báo', 
                    subtitle: 'Đặt bất kỳ loại tin nhắn thông báo nào',
                    onTap: () => Get.to(() => const NotificationsSrceen()),
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.security_card, 
                    title: 'Bảo mật tài khoản', 
                    subtitle: 'Quản lý việc sử dụng dữ liệu và tài khoản được kết nối',
                  ),

                  // /// App Settings
                  // const SizedBox(height: TSizes.spaceBtwSections),
                  // const TSectionHeading(title: 'Cài đặt ứng dụng', showActionButton: false),
                  // const SizedBox(height: TSizes.spaceBtwItems),
                  // const TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Tải dữ liệu', subtitle: 'Đăng tải dữ liệu đến Cloud Firebase'),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.location,
                  //   title: 'Định vị',
                  //   subtitle: 'Đặt đề xuất dựa trên vị trí ',
                  //   trailing: Switch(value: false, onChanged: (value){},),
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.security_user,
                  //   title: 'Chế độ an toàn',
                  //   subtitle: 'Tìm kiếm kết quả an toàn cho mọi lứa tuổi',
                  //   trailing: Switch(value: false, onChanged: (value){},),
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.image,
                  //   title: 'Chất lượng hình ảnh HD',
                  //   subtitle: 'Đặt chất lượng hình ảnh để xem',
                  //   trailing: Switch(value: false, onChanged: (value){},),
                  // ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity, 
                    child: OutlinedButton(
                    onPressed: () => Get.to(() => const LoginScreen()), 
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: TColors.primary)), child: const Text('Đăng xuất')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
