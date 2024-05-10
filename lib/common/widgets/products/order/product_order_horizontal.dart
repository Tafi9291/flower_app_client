import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_store/api/order_api_handler.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/data/models/Order.dart';
import 'package:t_store/data/models/OrderDetail.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/features/shop/screens/order/widgets/order_detail_price_item.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

import '../../../../admin/utils/constants/image_strings.dart';

class TProductOrderHorizontal extends StatefulWidget {
  const TProductOrderHorizontal({super.key, required this.orderId, required this.userId, required this.subTotalPrice, required this.finalPrice});

  final int orderId;
  final int userId;
  final int subTotalPrice, finalPrice;

  @override
  State<TProductOrderHorizontal> createState() => _TProductOrderHorizontalState();
}

class _TProductOrderHorizontalState extends State<TProductOrderHorizontal> {

  final OrderApiHandler _orderStatusApi = OrderApiHandler();
  late List<OrderDetail> orderDetails = [];
  late List<Product> dataPro = [];

  final DataService  dataService = DataService();

  @override
  void initState() {
    super.initState();
    fetchOrderDetail();
    getProductData();
  }

  void fetchOrderDetail() async {
    try {
      List<OrderDetail> details = await _orderStatusApi.getOrderDetail();
      setState(() {
        orderDetails = details.where((detail) => detail.orderId == widget.orderId).toList(); // Lọc theo orderId truyền vào
      });
    } catch (error) {
      print('Error fetching order detail: $error');
    }
  }

  void getProductData() async {
    try {
      final List<Product> response = await dataService.getProductData(); // Use the getData method from the DataService
      setState(() {
        dataPro = response;
      });
    } catch (e) {
      print('Failed to load detail: $e');
    }
  }
  
   @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);


    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        border: Border.all(width: 0.5, style: BorderStyle.solid, color: const Color.fromARGB(255, 131, 131, 131)),
        color: dark ? TColors.darkerGrey : TColors.softGrey,
      ),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderDetails.length,
            separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (_, index) {
              final orderDetail = orderDetails[index];
              final product = dataPro.firstWhere((prod) => prod.productId == orderDetail.productId); // Find the product by productId
              // Build UI for each order detail item
              return GestureDetector(
                // onTap: () => Get.to(() => const ProductDetailScreen()),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Thumbnail
                        TRoundedContainer(
                          height: 150,
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.md),
                          backgroundColor: dark ? TColors.dark : TColors.light,
                          child: Stack(
                            children: [
                              // Thumbnail Image
                              TRoundedImage(imageUrl: product.imageUrl ?? '', applyImageRadius: true, height: 120, width: 80, isNetWorkImage: true,), // Use product imageUrl
                            ],
                          ),
                        ),
                        // Details
                        SizedBox(
                          width: 255,
                          child: Padding(
                            padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product name
                                SizedBox(
                                  width: 200,
                                  child: TProductTitleText(title: product.productName), // Use product productName
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems / 2),
                                // Additional product information
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: 'Loại: ', style: Theme.of(context).textTheme.bodySmall),
                                      TextSpan(text: product.category?.categoryName ?? '', style: Theme.of(context).textTheme.bodyLarge), // Use product category name
                                    ],
                                  ),
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems / 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Quantity
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: 'Số lượng: ', style: Theme.of(context).textTheme.bodySmall),
                                          TextSpan(text: orderDetail.quantity.toString(), style: Theme.of(context).textTheme.bodyLarge),
                                        ],
                                      ),
                                    ),
                                    // Price
                                    Text(NumberFormat("#,##0 đ").format(orderDetail.totalPrice), style: Theme.of(context).textTheme.bodyLarge),
                                  ],
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems / 2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Padding(
            padding: EdgeInsets.all(TSizes.sm),
            child: Column(
              children: [
                /// Price info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tổng tiền hàng', style: TextStyle(fontSize: 16),),
                    Text(NumberFormat("#,##0 đ").format(widget.subTotalPrice)),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tiền ship', style: TextStyle(fontSize: 16),),
                    Text('0 đ'),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Thành tiền', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    TProductPriceText(price: NumberFormat("#,##0").format(widget.finalPrice)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

