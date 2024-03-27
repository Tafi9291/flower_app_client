import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/admin/featured/password_configuration/forget_password.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  State<TLoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<TLoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthUserApiHandler loginAdminApiHandler = AuthUserApiHandler();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final String? token = await loginAdminApiHandler.login(email, password);

    if (token != null) {
      // Login success, navigate to next screen
      Get.to(() => const NavigationMenu());
    } else {
      // Show error message
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Lỗi', style: TextStyle(fontSize: 17)),
          content: const Text('Email hoặc mật khẩu không chính xác!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng', style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash)),
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
                  const Text(TTexts.rememberMe, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                ],
              ),

              /// Forgot Password
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()), child: const Text(TTexts.forgetPassword, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Sign In Button
          SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  // onPressed: () => Get.to(() => const NavigationMenu()),
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), 
                  child: const Text(TTexts.signIn, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)))
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
        ]),
      ),
    );
  }
}