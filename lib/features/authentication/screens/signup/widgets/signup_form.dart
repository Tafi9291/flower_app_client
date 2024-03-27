import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class TSignUpForm extends StatefulWidget {
  const TSignUpForm({super.key});

  @override
  State<TSignUpForm> createState() => _TSignUpFormState();
}

class _TSignUpFormState extends State<TSignUpForm> {
  final controller =  Get.put(LoginController());
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthUserApiHandler registerApiHandler = AuthUserApiHandler();


  Future<void> _register() async {
      final String firstName = _firstNameController.text;
      final String lastName = _lastNameController.text;
      final String nickName = _nickNameController.text;
      final String phoneNumber = _phoneNumberController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String confirmPassword = _confirmPasswordController.text;

      final bool isNotRegistered = await registerApiHandler.checkEmailExist(email);

      if (firstName.isEmpty ||
          lastName.isEmpty ||
          nickName.isEmpty ||
          phoneNumber.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        // Một hoặc nhiều trường thông tin còn bị trống
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Lỗi', style: TextStyle(fontSize: 17)),
            content: const Text('Thông tin còn bị trống. Hãy kiểm tra lại.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        );
        return; // Ngăn không tiếp tục xử lý
      }
      
      if (!isNotRegistered) {
        // Email đã được sử dụng
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Lỗi', style: TextStyle(fontSize: 17)),
            content: const Text('Email đã được sử dụng! Hãy thử lại với email khác.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        );
        return; // Ngăn không tiếp tục xử lý
      }

      if (password != confirmPassword) {
        // Mật khẩu nhập lại không khớp
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Lỗi', style: TextStyle(fontSize: 17)),
            content: const Text('Mật khẩu nhập lại không khớp. Hãy thử lại.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        );
        return; // Ngăn không tiếp tục xử lý
      }

      
      // Nếu tất cả điều kiện đều đúng, tiến hành đăng ký
      final String? token = await registerApiHandler.register(firstName, lastName, nickName, email, phoneNumber, password);

      if (token != null) {
        // Đăng ký thành công
        Get.to(() => SuccessScreen(
          image: TImages.staticSuccessIllustration,
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => Get.to(() => const LoginScreen()),
        ));
      }
    }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          /// Firstname & lastname
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
    
          /// Username
          TextFormField(
            controller: _nickNameController,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
    
          /// Email
          TextFormField(
            controller: _emailController,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
    
          /// Phone number
          TextFormField(
            controller: _phoneNumberController,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.phoneNo,
                prefixIcon: Icon(Iconsax.call)),
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
          const SizedBox(height: TSizes.spaceBtwInputFields),
    
          /// Confirm Password
          Obx(
            () => TextFormField(
              controller: _confirmPasswordController,
              obscureText: controller.hideConfirmPassword.value,
              decoration: InputDecoration(
                  labelText: TTexts.confirmPassword,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hideConfirmPassword.value = !controller.hideConfirmPassword.value,
                    icon: Icon(controller.hideConfirmPassword.value ? Iconsax.eye_slash : Iconsax.eye)),
                  ), 
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Terms&Conditions Checkbox
          const TTermsAndConditionsCheckBox(),
          const SizedBox(height: TSizes.spaceBtwSections),
          /// Sign up button
          SizedBox(
            width: double.infinity, 
            height: 50,
            child: ElevatedButton(
              // onPressed: () => Get.to(() => const VerifyEmailScreen()),
              onPressed: _register,
              style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary),
              child: const Text(TTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}

