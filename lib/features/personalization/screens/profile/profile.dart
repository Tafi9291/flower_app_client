import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                    const TCircularImage(image: TImages.user, width: 80, height: 80),
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

              TProfileMenu(title: 'Họ tên', value: 'Tafi', onPressed: () {}),
              TProfileMenu(title: 'Tên người dùng', value: 'tafi', onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              const TSectionHeading(title: 'Thông tin cá nhân', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'ID người dùng', value: '9898', icon: Iconsax.copy, onPressed: () {}),
              TProfileMenu(title: 'E-mail', value: 'tafi@gmail.com', onPressed: () {}),
              TProfileMenu(title: 'Điện thoại', value: '+92-317-8059528', onPressed: () {}),
              TProfileMenu(title: 'Giởi tính', value: 'Male', onPressed: () {}),
              TProfileMenu(title: 'Ngày sinh', value: '10 Oct, 2000', onPressed: () {}),
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
