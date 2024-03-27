import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/admin/common/widgets/appbar/appbar.dart';
import 'package:t_store/admin/common/widgets/images/t_circular_image.dart';
import 'package:t_store/admin/common/widgets/texts/section_heading.dart';
import 'package:t_store/admin/featured/account/widgets/profile_menu.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
    return Scaffold(
      appBar: TAppBar(
        leadingIcon: Icons.menu, 
        leadingOnPressed: (){Scaffold.of(context).openDrawer();}, 
        title: const Text('Tài khoản'),
      ),
      /// Body
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TCircularImage(image: adminDetail['imageUrl'] != null && adminDetail['imageUrl'].isNotEmpty ? adminDetail['imageUrl']! : TImages.user, width: 80, height: 80),
                    TextButton(onPressed: (){}, child: const Text('Thay đổi ảnh đại diện')),
                  ],
                ),
              ),

              /// Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(title: 'Thông tin tài khoản', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'Họ tên', value: '${adminDetail['firstName']} ${adminDetail['lastName']}', onPressed: () {}),
              // TProfileMenu(title: 'Tên người dùng', value: 'tafi', onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              const TSectionHeading(title: 'Thông tin cá nhân', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'ID người dùng', value: '${adminDetail['usersId']}', icon: Iconsax.copy, onPressed: () {}),
              TProfileMenu(title: 'E-mail', value: '${adminDetail['email']}', onPressed: () {}),
              TProfileMenu(title: 'Điện thoại', value: '${adminDetail['phoneNumber']}', onPressed: () {}),
              TProfileMenu(title: 'Giởi tính', value: '${adminDetail['gender']}', onPressed: () {}),
              TProfileMenu(title: 'Ngày sinh', value: '${adminDetail['birthDay']}', onPressed: () {}),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: logout,
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: TColors.primary, width: 2), backgroundColor: const Color.fromARGB(255, 254, 254, 254)),
                    child: const Text('Đăng xuất', style: TextStyle(color: Colors.black, fontSize: TSizes.md),),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}