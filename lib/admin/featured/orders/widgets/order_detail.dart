import 'package:intl/intl.dart';
import 'package:t_store/admin/common/widgets/products/order/product_order_horizontal.dart';
import 'package:t_store/admin/featured/orders/widgets/bottom_update_status_order.dart';
import 'package:t_store/admin/featured/orders/widgets/order_title_part.dart';
import 'package:flutter/material.dart';
import 'package:t_store/admin/common/widgets/appbar/appbar.dart';
import 'package:t_store/admin/common/widgets/texts/shipping_info_text.dart';
import 'package:t_store/api/order_api_handler.dart';
import 'package:t_store/data/models/Order.dart';
import 'package:t_store/data/models/OrderDetail.dart';
import 'package:t_store/data/models/OrderStatus.dart';
import 'package:t_store/utils/constants/sizes.dart';

final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.usersId, required this.orderId});

  final int usersId, orderId;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  final OrderApiHandler order = OrderApiHandler();

  late List<OrderStatus> orderStatus = [];
  OrderDetail? orderDetail;
  Order? orders;

  int? selectedOrderStatusId;

  @override
  void initState() {
    super.initState();
    // Fetch category details based on categoryId
    fetchOrderDetailData();
    fetchOrderData();
  }

  void fetchOrderData() async {
    try {
      // Fetch category details from API based on widget.categoryId
      final orderById = await order.getOrderById(widget.orderId);
      if (orderById != null) {
        // Set initial values in the form
        setState(() {
          // Set other initial values here if needed
          orders = orderById;
        });
      } else {
        // Handle error fetching category
      }
    } catch (e) {
      print('Failed to fetch category: $e');
      // Handle error fetching category
    }
  }

  void fetchOrderDetailData() async {
    try {
      // Fetch category details from API based on widget.categoryId
      final orders = await order.getOrderDetailById(widget.orderId);
      if (orders != null) {
        // Set initial values in the form
        setState(() {
          // Set other initial values here if needed
          orderDetail = orders;
        });
      } else {
        // Handle error fetching category
      }
    } catch (e) {
      print('Failed to fetch category: $e');
      // Handle error fetching category
    }
  }

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

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name, phone number, address
                    TShippingInfoText(title: 'Hà Vĩnh Tài'),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    TShippingInfoText(title: '0933519936'),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    TShippingInfoText(title: orders!.address!),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
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
                      Text(orders!.orderId.toString(), style: Theme.of(context).textTheme.headlineSmall,)
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TShippingInfoText(title: 'Thời gian đặt hàng'),
                      Text(dateFormat.format(orders!.createAt!), style: Theme.of(context).textTheme.bodyMedium,)
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
