import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/api/address_api_handler.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/data/models/Address.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TBillingAddressSection extends StatefulWidget {
  const TBillingAddressSection({super.key, required this.nickName, required this.phoneNumber, required this.address, required this.onAddressIdChanged});

  final String nickName, phoneNumber, address;

  final Function(int?) onAddressIdChanged; // Đối số này sẽ nhận giá trị địa chỉ mới

  @override
  State<TBillingAddressSection> createState() => _TBillingAddressSectionState();
}

class _TBillingAddressSectionState extends State<TBillingAddressSection> {

  List<Address> addresses = [];
  AddressApiHandler addressApiHandler = AddressApiHandler();
  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();
  String selectedAddress = '';
  int? selectedAddressId;


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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Địa chỉ giao hàng', 
          buttonTitle: 'Đổi',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Chọn địa chỉ', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16.0),
                      // Hiển thị danh sách địa chỉ trong ListView
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(addresses[index].address1.toString()),
                            onTap: () {
                              // Xử lý khi người dùng chọn địa chỉ
                              setState(() {
                                selectedAddressId = addresses[index].addressId;
                                selectedAddress = addresses[index].address1!;
                              });
                              widget.onAddressIdChanged(selectedAddressId);
                              Navigator.of(context).pop();
                              // Thực hiện các hành động khi người dùng chọn địa chỉ
                              // Ví dụ: Get.to(() => const UserAddressScreen());
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        Text(widget.nickName, style: Theme.of(context).textTheme.bodyLarge),

        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(widget.phoneNumber, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(selectedAddress.isNotEmpty ? selectedAddress : widget.address, style: Theme.of(context).textTheme.bodyMedium, softWrap: true),
          ],
        ),
      ],
    );
  }
}