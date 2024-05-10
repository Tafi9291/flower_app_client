import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/cart_api_handler.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';


class TProductQuantityWithAddRemoveButton extends StatefulWidget {
  const TProductQuantityWithAddRemoveButton({super.key, this.quantity, this.productId, this.onAddToCart});

  final int? quantity, productId;
  final VoidCallback? onAddToCart;

  @override
  State<TProductQuantityWithAddRemoveButton> createState() => _TProductQuantityWithAddRemoveButtonState();
}

class _TProductQuantityWithAddRemoveButtonState extends State<TProductQuantityWithAddRemoveButton> {
  
  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();

  List<Cart> carts = [];
  CartApiHandler  cartApi = CartApiHandler();
  
  Map<String, dynamic> customerDetail = {};

  int _quantity = 1;


  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity ?? 0;
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
      });
    } catch (e) {
      print('Failed to fetch cart: $e');
      // Handle error fetching category
    }
  }
  
  void addToCart() async {
    try {
      CartApiHandler apiHandler = CartApiHandler();
      final usersId = customerDetail['usersId'];
      // Lấy tham chiếu đến CartController
      final CartController cartController = Get.find<CartController>();
      final result = await apiHandler.addToCart(usersId, widget.productId!);
      if (result != null && result.contains('thành công')) {
        setState(() {
          _quantity++;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
            duration: const Duration(seconds: 2),
          ),
        );
        // Cập nhật giỏ hàng bằng cách gọi phương thức trong CartController
        cartController.fetchCart(customerDetail['email']);
        // Trì hoãn việc chuyển hướng sang trang mới sau 1.5s
        Future.delayed(const Duration(milliseconds: 1200), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thêm sản phẩm vào giỏ hàng thất bại.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Thêm sản phẩm vào giỏ hàng thất bại: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thêm sản phẩm vào giỏ hàng thất bại.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void removeFromCart() async {
    try {
      CartApiHandler apiHandler = CartApiHandler();
      final usersId = customerDetail['usersId'];
      // Lấy tham chiếu đến CartController
      final CartController cartController = Get.find<CartController>();
      final result = await apiHandler.removeFromCart(usersId, widget.productId!);
      if (result != null && result.contains('thành công')) {
        setState(() {
          _quantity--;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
            duration: const Duration(seconds: 2),
          ),
        );
        // Cập nhật giỏ hàng bằng cách gọi phương thức trong CartController
        cartController.fetchCart(customerDetail['email']);
        // Trì hoãn việc chuyển hướng sang trang mới sau 1.5s
        Future.delayed(const Duration(milliseconds: 1200), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cập nhật giỏ hàng thất bại.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Cập nhật giỏ hàng thất bại: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cập nhật giỏ hàng thất bại.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          onPressed: removeFromCart,
          height: 32,
          size: TSizes.md,
          color: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.black,
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text('$_quantity', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: TSizes.spaceBtwItems),
    
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(BorderSide.none),
          ),
          onPressed: addToCart,
          child: const TCircularIcon(
            icon: Iconsax.add,
            width: 32,
            height: 32,
            size: TSizes.md,
            color: TColors.black,
            backgroundColor: TColors.primary,
          ),
        ),
      ],
    );
  }
}
