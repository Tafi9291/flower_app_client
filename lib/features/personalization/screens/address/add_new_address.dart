import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

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
                TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Họ tên')),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Icons.phone), labelText: 'Số điện thoại')),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Icons.home), labelText: 'Địa chỉ')),
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
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), child: const Text('Lưu'),),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}