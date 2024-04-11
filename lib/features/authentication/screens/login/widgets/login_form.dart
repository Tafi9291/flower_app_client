// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/admin/navigation_menu.dart';
import 'package:t_store/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:t_store/features/authentication/screens/signup/signup.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/popup/loaders.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  @override
  Widget build(BuildContext context) {
    final controller =  Get.put(LoginController());
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final AuthUserApiHandler loginApiHandler = AuthUserApiHandler();

    Future<void> _login() async {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      final String? token = await loginApiHandler.login(email, password);

      if (token != null) {
        // Lấy thông tin người dùng từ máy chủ
        final userInfo = await loginApiHandler.getUserDetail();
        // Login success, navigate to next screen
        // Kiểm tra role của người dùng
        // ignore: unnecessary_null_comparison
        if (userInfo != null && userInfo['rolesId'] == 1) {
          // Nếu có role là 1, điều hướng tới trang admin
          Get.to(() => const NavigationAdminMenu());
        } else if (userInfo['rolesId'] == 2) {
          // Nếu không, điều hướng tới trang của client
          Get.to(() => const NavigationMenu());
        }
      } else {
        // Show error message
        // ignore: use_build_context_synchronously
        TLoaders.warningSnackBar(title: 'Cảnh báo', message: 'Email hoặc mật khẩu không chính xác!'.tr);
        // showDialog(
        //   // ignore: use_build_context_synchronously
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     title: const Text('Lỗi', style: TextStyle(fontSize: 17)),
        //     content: const Text('Email hoặc mật khẩu không chính xác!'),
        //     actions: [
        //       TextButton(
        //         onPressed: () => Navigator.pop(context),
        //         child: const Text('Đóng', style: TextStyle(fontSize: 16),),
        //       ),
        //     ],
        //   ),
        // );
      }
    }

    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(children: [
          /// Email
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              controller: _passwordController,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)),
                  ), 
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields / 2),

          /// Rememner me & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Remember me
              Row(
                children: [
                  Checkbox(
                    value: true,
                    activeColor: TColors.primary,
                    onChanged: (value) {}),
                  const Text(TTexts.rememberMe, style: TextStyle(fontSize: 16),),
                ],
              ),

              /// Forgot Password
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()), child: const Text(TTexts.forgetPassword, style: TextStyle(fontSize: 16),)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Sign In Button
          SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  onPressed: _login, 
                  style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), 
                  child: const Text(TTexts.signIn, style: TextStyle(fontSize: 20),))
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Create account button
          SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => const SignUpScreen()),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: TColors.darkPrimary)),
                  child: const Text(TTexts.createAccount))),
          const SizedBox(height: TSizes.spaceBtwSections),
        ]),
      ),
    );
  }
}


