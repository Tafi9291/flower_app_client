import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/api/address_api_handler.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/data/models/Address.dart';
import 'package:t_store/features/personalization/screens/address/add_new_address.dart';
import 'package:t_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class UserAddressScreen extends StatefulWidget {
  const UserAddressScreen({super.key});

  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {

  List<Address> addresses = [];
  AddressApiHandler addressApiHandler = AddressApiHandler();
  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();


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
      if (customerDetail['usersId'] != null) {
        fetchAddresses(customerDetail['usersId']);
      } else {
        print('Customer id is null');
        // Xử lý khi 'email' là null, có thể hiển thị thông báo lỗi hoặc thực hiện hành động phù hợp khác
      }
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  Future<void> fetchAddresses(int usersId) async {
    try {
      // Replace userId with the actual user ID
      addresses = await addressApiHandler.getAddressesByUserId(usersId);
      setState(() {}); // Refresh UI
    } catch (error) {
      print('Error fetching addresses: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Địa chỉ của bạn', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return TSingleAddress(selectedAddress: true, address: address.address1,); // You can pass address data to TSingleAddress widget
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}