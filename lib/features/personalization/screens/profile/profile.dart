import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();

  Map<String, dynamic> customerDetail = {};

  @override
  void initState() {
    super.initState();
    loadcustomerDetail();
  }

  void loadcustomerDetail() async {
    try {
      final customerDetailResponse = await customerApiHandler.getUserDetail();
      setState(() {
        customerDetail = customerDetailResponse;
      });
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Tài khoản', style: Theme.of(context).textTheme.headlineMedium,)),

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
                    TCircularImage(image: customerDetail['imageUrl'] != null && customerDetail['imageUrl'].isNotEmpty ? customerDetail['imageUrl']! : TImages.user, width: 80, height: 80),
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

              TProfileMenu(title: 'Họ tên', value: '${customerDetail['firstName']} ${customerDetail['lastName']}', onPressed: () {}),
              TProfileMenu(title: 'Tên người dùng', value: '${customerDetail['nickName']}', onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              const TSectionHeading(title: 'Thông tin cá nhân', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'ID người dùng', value: '${customerDetail['usersId']}', icon: Iconsax.copy, onPressed: () {}),
              TProfileMenu(title: 'E-mail', value: '${customerDetail['email']}', onPressed: () {}),
              TProfileMenu(title: 'Điện thoại', value: '${customerDetail['phoneNumber']}', onPressed: () {}),
              TProfileMenu(title: 'Giởi tính', value: customerDetail['gender'] != null ? customerDetail['gender']! : 'Chưa có', onPressed: () {}),
              TProfileMenu(title: 'Ngày sinh', value: customerDetail['birthDay'] != null ? customerDetail['birthDay']! : 'Chưa có', onPressed: () {}),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),

              // Center(
              //   child: TextButton(
              //     onPressed: (){},
              //     child: const Text('Đóng tài khoản', style: TextStyle(color: Colors.red, fontSize: TSizes.md),),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}

