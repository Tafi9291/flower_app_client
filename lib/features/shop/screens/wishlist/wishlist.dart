import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/layouts/gird_layouts.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/utils/constants/sizes.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  final ProductApiHandler productApiHandler = ProductApiHandler();
  late List<Product> favoriteProducts = [];

  late List<Category> dataCate = [];

  final DataService  dataService = DataService();
  
  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();

  @override
  void initState() {
    super.initState();
    getCategoryData();
    loadcustomerDetail();
  }

  Map<String, dynamic> customerDetail = {};

  void loadcustomerDetail() async {
    try {
      final customerDetailResponse = await customerApiHandler.getUserDetail();
      setState(() {
        customerDetail = customerDetailResponse;
      });

      if (customerDetail['email'] != null) {
        getFavoriteProducts(customerDetail['email']);
      } else {
        print('Customer email is null');
        // Xử lý khi 'email' là null, có thể hiển thị thông báo lỗi hoặc thực hiện hành động phù hợp khác
      }
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  void getCategoryData() async {
    try {
      final List<Category> response = await dataService.getCategoryData(); // Use the getData method from the DataService
      setState(() {
        dataCate = response;
      });
    } catch (e) {
      print('Failed to load detail: $e');
    }
  }


  Future<void> getFavoriteProducts(String email) async {
    try {
      final dynamic response = await productApiHandler.getFavoriteProductsByEmail(email);
      if (response != null) {
        final List<Product> products = (response as List).map((data) => Product.fromJson(data)).toList();
        setState(() {
          favoriteProducts = products;
        });
      } else {
        print('Favorite products response is null');
      }
    } catch (e) {
      print('Failed to load favorite products: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Yêu thích', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          // TCircularIcon(icon: Iconsax.add, onPressed: (){},),
        ],
      ),

      body: favoriteProducts.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Không có sản phẩm yêu thích',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            :  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    TGridLayout(itemCount: favoriteProducts.length, itemBuilder: (_, index) => TProductCardVertical(
                      productId: favoriteProducts[index].productId, 
                      name: favoriteProducts[index].productName, 
                      category: favoriteProducts[index].category != null ? favoriteProducts[index].category!.categoryName : '',
                      image: favoriteProducts[index].imageUrl != null ? favoriteProducts[index].imageUrl! : '',
                      price: NumberFormat("#,##0").format(favoriteProducts[index].price ?? 0),
                      percentDis: favoriteProducts[index].percentDis!,
                      salePrice: NumberFormat("#,##0").format(favoriteProducts[index].salePrice ?? ''),
                    )),
                  ],
                ),
              ),
            ),
    );
  }
}
