import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/order/product_order_horizontal.dart';
import 'package:t_store/common/widgets/texts/shipping_info_text.dart';
import 'package:t_store/data/models/Order.dart';
import 'package:t_store/features/shop/screens/order/widgets/order_title_part.dart';
import 'package:t_store/utils/constants/sizes.dart';

final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, 
    required this.orderDetail, 
    required this.name, 
    required this.phoneNumber
  });

  final Order orderDetail;
  final String name, phoneNumber;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Chi tiết đơn hàng', style: Theme.of(context).textTheme.headlineMedium,), showBackArrow: true),
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

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name, phone number, address
                    TShippingInfoText(title: widget.name),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    TShippingInfoText(title: widget.phoneNumber),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    TShippingInfoText(title: '${widget.orderDetail.address}'),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Product Order info
              Column(
                children: [
                  SizedBox(
                    height: null,
                    width: double.infinity,
                    child: TProductOrderHorizontal(
                      orderId: widget.orderDetail.orderId, 
                      userId: widget.orderDetail.usersId!, 
                      subTotalPrice: widget.orderDetail.finalPrice!,
                      finalPrice: widget.orderDetail.finalPrice!,
                    ),
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
                      Text('#${widget.orderDetail.orderId}', style: Theme.of(context).textTheme.headlineSmall,)
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TShippingInfoText(title: 'Thời gian đặt hàng'),
                      Text(dateFormat.format(widget.orderDetail.createAt!), style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TShippingInfoText(title: 'Thời gian hoàn thành'),
                      Text('2 ngày sau khi đặt', style: Theme.of(context).textTheme.bodyMedium,)
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
