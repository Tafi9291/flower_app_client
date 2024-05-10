import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:t_store/api/address_api_handler.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/cart_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/data/models/Address.dart';
import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store/features/shop/screens/checkout/checkout.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  List<Cart> carts = [];
  Map<String, dynamic> customerDetail = {};
  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();
  final DataService  dataService = DataService();
  CartApiHandler  cartApi = CartApiHandler();
  List<Address> addresses = [];
  AddressApiHandler addressApiHandler = AddressApiHandler();
  int? defaultAddressId;
  String? defaultAddressName;

  @override
  void initState() {
    super.initState();
    loadcustomerDetail();
  }

  void loadcustomerDetail() async {
    try {
      final customerDetailResponse = await customerApiHandler.getUserDetail();
      setState(() {
        customerDetail = customerDetailResponse;
        fetchCart(customerDetail['email']);
        fetchAddresses(customerDetail['usersId']);
      });
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  Future<void> fetchAddresses(int usersId) async {
    try {
      // Replace userId with the actual user ID
      addresses = await addressApiHandler.getAddressesByUserId(usersId);
      // Nếu danh sách địa chỉ không rỗng và biến addressIdDefault chưa được gán
      if (addresses.isNotEmpty) {
        // Lấy addressId của địa chỉ đầu tiên và gán vào biến addressIdDefault
        defaultAddressId = addresses.first.addressId;
        defaultAddressName = addresses.first.address1;
      }
      setState(() {}); // Refresh UI
    } catch (error) {
      print('Error fetching addresses: $error');
    }
  }

  void fetchCart(String email) async {
    try {
      // Fetch category details from API based on widget.categoryId
      final List<dynamic> response = await cartApi.getCartsByEmail(email);
      final List<Cart> cartList = response.map((item) => Cart.fromJson(item)).toList();
      int totalPrice = 0;
      for (final cartItem in cartList) {
        if (cartItem.usersId == customerDetail['usersId']) {
          totalPrice += cartItem.subtotalPrice!;
        }
      }
      setState(() {
        carts = cartList;
      });
    } catch (e) {
      print('Failed to fetch cart: $e');
      // Handle error fetching category
    }
  }

  int? getTotalPriceForUser(int? usersId) {
    int total = 0;
    for (final cartItem in carts) {
      if (cartItem.usersId == usersId) {
        total += cartItem.subtotalPrice!;
      }
    }
    return total;
  }


  @override
  Widget build(BuildContext context) {
    // final List<String> userAddresses = List<String>.from(customerDetail['addresses'] ?? []);
    final int? totalPriceForUser = getTotalPriceForUser(customerDetail['usersId'] as int?);
    // final String addressesAsString = userAddresses.join(', '); // Chuyển danh sách địa chỉ thành một chuỗi duy nhất
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Giỏ hàng', style: Theme.of(context).textTheme.headlineMedium)),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        /// Items in cart
        child: TCartItems(),
      ),

      /// Checkout Button
      bottomNavigationBar: totalPriceForUser != 0
      ? Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => CheckoutScreen(
            totalPrice: NumberFormat("#,##0 đ").format(totalPriceForUser),
            usersId: customerDetail['usersId'],
            nickName: customerDetail['nickName'],
            phoneNumber: customerDetail['phoneNumber'],
            addressIdDefault: defaultAddressId,
            addressName: defaultAddressName,
          )), 
          style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary),
          child: Text('Thanh toán ${NumberFormat("#,##0 đ").format(totalPriceForUser)}')),
      )
      : SizedBox(), // Ẩn nút khi totalPriceForUser bằng 0
    );
  }
}


