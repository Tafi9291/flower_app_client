import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/cart_api_handler.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/common/styles/shadows.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/features/shop/screens/product_details/product_detail.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/data/models/Product.dart';

class TProductCardVertical extends StatefulWidget {
  const TProductCardVertical({super.key,
    required this.productId, 
    required this.name, 
    required this.category, 
    required this.image, 
    this.stockQl, 
    required this.price,
    required this.salePrice,
    required this.percentDis, 
  });

  final int productId;
  final String name, category, image;
  final int? stockQl;
  final String price, salePrice;
  final int percentDis;

  @override
  State<TProductCardVertical> createState() => _TProductCardVerticalState();
}

class _TProductCardVerticalState extends State<TProductCardVertical> {

  bool? isFavorite;

  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();
  
  Map<String, dynamic> customerDetail = {};


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
        // Kiểm tra xem sản phẩm có trong danh sách yêu thích của người dùng không
        final List<dynamic>? products = customerDetail['products'];
        isFavorite = products?.any((product) => product['productId'] == widget.productId) ?? false;
      });
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  void toggleFavorite() async {
    if (customerDetail['email'] != null) {
      // Tiếp tục thực hiện hành động khi email không null
      ProductApiHandler apiHandler = ProductApiHandler();
      // Nếu sản phẩm chưa được thêm vào danh sách yêu thích, thêm nó vào
      // Nếu đã tồn tại trong danh sách, xóa nó khỏi danh sách
      if (!(isFavorite ?? false)) {
        final result = await apiHandler.addToFavorite(customerDetail['email'], widget.productId);
        if (result != null) {
          setState(() {
            isFavorite = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to add product to favorites.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        final result = await apiHandler.removeFromFavorite(customerDetail['email'], widget.productId);
        if (result != null) {
          setState(() {
            isFavorite = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to remove product from favorites.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } else {
      // Xử lý khi email là null
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get email from token.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  void addToCart() async {
    try {
      CartApiHandler apiHandler = CartApiHandler();
      final usersId = customerDetail['usersId'];
      final CartController cartController = Get.find<CartController>();
      final result = await apiHandler.addToCart(usersId, widget.productId);
      if (result != null && result.contains('thành công')) { // Check if result indicates successful addition
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
            duration: const Duration(seconds: 2),
          ),
        );
        // Cập nhật giỏ hàng bằng cách gọi phương thức trong CartController
        cartController.fetchCart(customerDetail['email']);
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



  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailSrceen(productId: widget.productId)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white,
        ),
        child: Column(
          children: [
            /// Thumbnail, WishList Button, Discount Tag
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm) ,
              backgroundColor: dark ?  TColors.dark : TColors.light,
              child: Stack(
                children: [
                  /// Thumbnail Page
                  TRoundedImage(imageUrl: widget.image, applyImageRadius: true, isNetWorkImage: true,),
                  /// Sale tag
                  Positioned(
                    top: 12,
                    child: widget.percentDis != 0 ?
                    TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text('${widget.percentDis}%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),),
                    ) :
                    SizedBox(), // Nếu percentDis bằng 0, không hiển thị gì cả
                  ),
      
                  /// Favourite Icon button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(
                      icon: Iconsax.heart5, color: isFavorite == true ? Colors.red : Colors.grey, 
                      onPressed: toggleFavorite,
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
      
            /// Detail
            Padding(
              padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TProductTitleText(title: widget.name, smallSize: true,),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TBrandTitleWithVerifiedIcon(title: widget.category),
                ],
              ),
            ),

            // Todo: Add Space() here to keep the height of each box same in case 1 or 2 line of Headings.
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Column(
                  children: [
                    /// Price
                    // Kiểm tra nếu price khác salePrice, hiển thị giá gốc
                    if (widget.price != widget.salePrice)
                      Padding(
                        padding: const EdgeInsets.only(left: TSizes.sm),
                        child: Text('${widget.price} đ',  style: Theme.of(context).textTheme.bodySmall!.apply(decoration: TextDecoration.lineThrough)),
                      ),
                    // Hiển thị giá giảm giá
                    Padding(
                      padding: const EdgeInsets.only(left: TSizes.sm),
                      child: TProductPriceText(price: widget.salePrice),
                    ),
                  ],
                ),
                /// Add to cart button
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.darkPrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(child: ElevatedButton(
                      onPressed: addToCart,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        side: MaterialStateProperty.all(BorderSide.none),
                      ),
                      child: const Icon(Iconsax.add, color: TColors.white))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}







