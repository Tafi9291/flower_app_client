import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_store/api/order_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/products/cart/coupon_widget.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/checkout_product.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, 
    required this.totalPrice, 
    required this.nickName, 
    required this.phoneNumber, 
    this.addressId, 
    required this.usersId, 
    this.addressIdDefault,
    this.addressName,
  });

  final String totalPrice;
  final int? usersId;
  final String nickName, phoneNumber;
  final int? addressIdDefault;
  final int? addressId;
  final String? addressName;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  final OrderApiHandler _orderService = OrderApiHandler(); // Thay thế ProductService bằng tên service của bạn

  late int? _addressId;

  @override
  void initState() {
    super.initState();
    _addressId = widget.addressId;
  }

  Future<void> _createOrder() async {
    try {
      final int? userId = widget.usersId;
      int? addressId = _addressId;
      if (addressId == null) {
        addressId = widget.addressIdDefault;
      }
      if(userId != null) {
        await _orderService.createOrder(userId, addressId); // Gọi hàm createOrder từ service của bạn
        Get.to(() => SuccessScreen(
          image: TImages.successfulPaymentIcon,
          title: 'Thanh toán thành công!',
          subtitle: 'Các mặt hàng của bạn sẽ sớm được vận chuyển!',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ));
      } else {
        const message = 'Id người không tồn tại. Vui lòng thử lại sau.';
      _showErrorSnackbar(message);
      }
    } catch (e) {
      print('Error creating order: $e');
      // Xử lý lỗi khi tạo đơn hàng
      const message = 'Đã xảy ra lỗi khi thanh toán. Vui lòng thử lại sau.';
      _showErrorSnackbar(message);
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Lỗi',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }


  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Thanh toán', style: Theme.of(context).textTheme.headlineMedium)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in cart
              const TCheckoutProduct(showAddRemoveButtons: true),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Coupon TextField
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(subTotal: widget.totalPrice, finalPrice: widget.totalPrice,),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    const TBillingPaymentSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    
                    /// Address
                    TBillingAddressSection(
                      nickName: widget.nickName, 
                      phoneNumber: widget.phoneNumber, 
                      address: widget.addressName.toString(),
                      onAddressIdChanged: (newAddressId) {
                        setState(() {
                          _addressId = newAddressId;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: _createOrder,
          style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), 
          child: Text('Thanh toán ${widget.totalPrice}'), 
        ),
      ),
    );
  }
}

