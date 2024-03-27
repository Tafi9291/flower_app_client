import 'package:t_store/admin/common/widgets/products/order/product_order_horizontal.dart';
import 'package:t_store/admin/featured/orders/widgets/bottom_update_status_order.dart';
import 'package:t_store/admin/featured/orders/widgets/order_title_part.dart';
import 'package:flutter/material.dart';
import 'package:t_store/admin/common/widgets/appbar/appbar.dart';
import 'package:t_store/admin/common/widgets/texts/shipping_info_text.dart';
import 'package:t_store/utils/constants/sizes.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Chi tiết đơn hàng', style: Theme.of(context).textTheme.headlineMedium,), showBackArrow: true),
      bottomNavigationBar: const TBottomUpdateStatusOrder(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Shipping location
              const TOrderTitlePart(title: 'Địa chỉ nhận hàng', icon: Icon(Icons.location_on),),

              const Padding(
                padding: EdgeInsets.only(top: 10, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name, phone number, address
                    TShippingInfoText(title: 'Hà Vĩnh Tài'),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    TShippingInfoText(title: '0933519936'),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    TShippingInfoText(title: '123 Nguyễn Trãi P11, Q5'),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Product Order info
              const Column(
                children: [
                  SizedBox(
                    height: null,
                    width: double.infinity,
                    child: TProductOrderHorizontal(),
                    ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Payment method
              const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TOrderTitlePart(title: 'Phương thức thanh toán', icon: Icon(Icons.payments)),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 40),
                      child: TShippingInfoText(title: 'Thanh toán khi nhận hàng',)
                    )
                  ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),

              /// Product code, Order date
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TOrderTitlePart(title: 'Mã đơn hàng', spacing: 0),
                      Text('#003123', style: Theme.of(context).textTheme.headlineSmall,)
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TShippingInfoText(title: 'Thời gian đặt hàng'),
                      Text('29/02/2024', style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TShippingInfoText(title: 'Thời gian hoàn thành'),
                      Text('02/03/2024', style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
