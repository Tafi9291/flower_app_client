import 'package:get/get.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/cart_api_handler.dart';
import 'package:t_store/data/models/Cart.dart';

class CartController extends GetxController {
  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();
  Map<String, dynamic> customerDetail = {};
  List<Cart> carts = [];
  CartApiHandler cartApi = CartApiHandler();
  var totalCartQuantityForUser = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCustomerDetail();
  }

  void loadCustomerDetail() async {
    try {
      final customerDetailResponse = await customerApiHandler.getUserDetail();
      customerDetail = customerDetailResponse;
      fetchCart(customerDetail['email']);
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  void fetchCart(String email) async {
    try {
      final List<dynamic> response = await cartApi.getCartsByEmail(email);
      final List<Cart> cartList = response.map((item) => Cart.fromJson(item)).toList();
      carts = cartList;
      totalCartQuantityForUser.value = _getTotalCartQuantityForUser();
    } catch (e) {
      print('Failed to fetch cart: $e');
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

  void updateCart(List<Cart> newCarts) {
    carts = newCarts;
    totalCartQuantityForUser.value = _getTotalCartQuantityForUser();
  }
}
