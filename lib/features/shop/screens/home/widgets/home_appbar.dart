import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/cart_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class THomeAppBar extends StatefulWidget {
  const THomeAppBar({super.key});


  @override
  State<THomeAppBar> createState() => _THomeAppBarState();
}

class _THomeAppBarState extends State<THomeAppBar> {

  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();
  final CartController cartController = Get.put(CartController());


  Map<String, dynamic> customerDetail = {};
  List<Cart> carts = [];
  CartApiHandler  cartApi = CartApiHandler();

  int totalCartQuantityForUser = 0;

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
      });
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  void fetchCart(String email) async {
    try {
      // Fetch category details from API based on widget.categoryId
      final List<dynamic> response = await cartApi.getCartsByEmail(email);
      final List<Cart> cartList = response.map((item) => Cart.fromJson(item)).toList();
      setState(() {
        carts = cartList;
        totalCartQuantityForUser = _getTotalCartQuantityForUser();
        cartController.updateCart(carts);
      });
      // Thông báo sự thay đổi trong carts cho CartController
    } catch (e) {
      print('Failed to fetch cart: $e');
      // Handle error fetching category
    }
  }

  int _getTotalCartQuantityForUser() {
    int total = 0;
    for (final cartItem in carts) {
      if (cartItem.usersId == customerDetail['usersId']) {
        total += cartItem.quantity!;
      }
    }
    return total;
  }

  // int? getTotalCartQuantityForUser(int? usersId) {
  //   int total = 0;
  //   for (final cartItem in carts) {
  //     if (cartItem.usersId == usersId) {
  //       total += cartItem.quantity!;
  //     }
  //   }
  //   return total;
  // }

  @override
  Widget build(BuildContext context) {
    // final int? totalCartQuantityForUser = getTotalCartQuantityForUser(customerDetail['usersId'] as int?);
    return Padding(
      padding: const EdgeInsets.only(top: 17.0),
      child: TAppBar(title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.dark)),
            Text('${customerDetail['firstName']} ${customerDetail['lastName']}', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.dark)),
          ],
        ),
        actions: [
          Obx(
            () => TCartCounterIcon(
              count: cartController.totalCartQuantityForUser.value,
              onPressed: () {},
              iconColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
