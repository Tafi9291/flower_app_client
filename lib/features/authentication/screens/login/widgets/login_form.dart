import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:t_store/features/authentication/screens/signup/signup.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(children: [
          /// Email
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          TextFormField(
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
                  onPressed: () => Get.to(() => const NavigationMenu()), 
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
