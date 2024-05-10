import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/cart_api_handler.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layouts/gird_layouts.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();

  Map<String, dynamic> customerDetail = {};
  final ProductApiHandler cate = ProductApiHandler();
  late List<Product> data = [];
  List<Cart> carts = [];
  CartApiHandler  cartApi = CartApiHandler();

  int totalCartQuantityForUser = 0;

  final DataService  dataService = DataService();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final List<Product> response = await dataService.getProductData(); // Use the getData method from the DataService
      setState(() {
        data = response;
      });
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  void loadcustomerDetail() async {
    try {
      final customerDetailResponse = await customerApiHandler.getUserDetail();
      setState(() {
        customerDetail = customerDetailResponse;
        
      });
      fetchCart(customerDetail['email']);
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
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header 
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Searchbar
                  TSearchContainer(text: "Tìm kiếm..."),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Catogories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Heading
                        TSectionHeading(title: 'Theo chủ đề', showActionButton: false),
                        SizedBox(height: TSizes.spaceBtwItems),

                        /// Categories
                        THomeCategories(),

                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections * 1.5),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Promo Slider
                  const TPromoSlider(banners: [TImages.bannerHoa, TImages.bannerLangHoa, TImages.bannerHoa2],),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Heading
                  TSectionHeading(title: 'Sản phẩm', onPressed: () => Get.to(() => const AllProducts())),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Popular Product
                  TGridLayout(itemCount: data.length, itemBuilder: (_, index) => TProductCardVertical(
                    productId: data[index].productId, 
                    name: data[index].productName, 
                    category: data[index].category!.categoryName,
                    image: data[index].imageUrl!, 
                    price: NumberFormat("#,##0").format(data[index].price ?? 0),
                    percentDis: data[index].percentDis!,
                    salePrice: NumberFormat("#,##0").format(data[index].salePrice ?? ''),
                    
                  )),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}











