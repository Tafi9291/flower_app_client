import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/api/address_api_handler.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/data/models/Address.dart';
import 'package:t_store/data/models/AddressCreateModel.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();
  AddressApiHandler addressApiHandler = AddressApiHandler();

  @override
  void initState() {
    super.initState();
    loadcustomerDetail();
  }

  Map<String, dynamic> customerDetail = {};

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

  void addAddress() async {
    final int usersId = customerDetail['usersId']; // Replace with the actual user ID
    final String address1 = addressController.text;

    final model = AddressCreateModel(usersId: usersId, address1: address1);

    try {
      final result = await addressApiHandler.createAddress(model);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          duration: const Duration(seconds: 2),
        ),
      );
      // Delay navigation to show the SnackBar
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserAddressScreen()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Thêm địa chỉ mới', style: Theme.of(context).textTheme.headlineMedium,)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                // TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Họ tên')),
                // const SizedBox(height: TSizes.spaceBtwInputFields),
                // TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Icons.phone), labelText: 'Số điện thoại')),
                // const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(controller: addressController, decoration: const InputDecoration(prefixIcon: Icon(Icons.home), labelText: 'Địa chỉ')),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                // Row(
                //   children: [
                //   Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.home1), labelText: 'Địa chỉ'))),
                //   const SizedBox(width: TSizes.spaceBtwInputFields),
                //   Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Phường'))), 
                //   ],
                // ),
                // const SizedBox(height: TSizes.spaceBtwInputFields),
                // Row(
                //   children: [
                //   Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'Quận'))),
                //   const SizedBox(width: TSizes.spaceBtwInputFields),
                //   Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'Thành phố'))), 
                //   ],
                // ),
                // const SizedBox(height: TSizes.spaceBtwInputFields),
                // TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country')),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: addAddress, style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), child: const Text('Lưu'),),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
