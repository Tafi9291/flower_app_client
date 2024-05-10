import 'package:flutter/material.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCartItem extends StatefulWidget {
  const TCartItem({super.key, required this.productId});

  final int productId;


  @override
  State<TCartItem> createState() => _TCartItemState();
}

class _TCartItemState extends State<TCartItem> {

  bool? isCart;

  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();
  
  Map<String, dynamic> customerDetail = {};


  late ProductApiHandler product = ProductApiHandler();
  late Future<void> _fetchProductFuture;
  late Product? data;

  @override
  void initState() {
    super.initState();
    // Fetch category details based on categoryId
    product = ProductApiHandler();
    _fetchProductFuture = fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Fetch category details from API based on widget.categoryId
      data = await product.getProductById(widget.productId);
      setState(() {});
    } catch (e) {
      print('Failed to fetch product: $e');
      // Handle error fetching category
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _fetchProductFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Row(
                children: [
                  /// Image
                  TRoundedImage(
                    imageUrl: data!.imageUrl!,
                    isNetWorkImage: true,
                    width: 90,
                    height: 90,
                    padding: const EdgeInsets.all(TSizes.sm),
                    backGroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
              
                  /// Title, Price and Size
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const TBrandTitleWithVerifiedIcon(title: 'Nike'),
                        Flexible(child: TProductTitleText(title: data!.productName, maxLine: 1)),
                        /// Attributes
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: 'Loại: ', style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(text: data!.category?.categoryName, style: Theme.of(context).textTheme.bodyLarge),
                              // TextSpan(text: ', ', style: Theme.of(context).textTheme.bodySmall),
                              // TextSpan(text: 'Size: ', style: Theme.of(context).textTheme.bodySmall),
                              // TextSpan(text: 'Bó lớn ', style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
        ),
      
    );
  }
}
