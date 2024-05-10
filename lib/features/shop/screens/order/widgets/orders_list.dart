import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/order_api_handler.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/data/models/Order.dart';
import 'package:t_store/features/shop/screens/order/widgets/order_detail.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

class TOrderListItems extends StatefulWidget {
  const TOrderListItems({super.key, required this.statusId});

  final int statusId;

  @override
  State<TOrderListItems> createState() => _TOrderListItemsState();
}

class _TOrderListItemsState extends State<TOrderListItems> {

  List<Order> _orders = []; // Danh sách đơn hàng
  bool _isLoading = true; // Biến để kiểm tra xem đang tải dữ liệu hay không
  final OrderApiHandler _orderStatusApi = OrderApiHandler();
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
        _getOrders(customerDetail['usersId']);
      });
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  Future<void> _getOrders(int usersId) async {
    try {
      // Lấy danh sách đơn hàng của người dùng từ hàm getOrdersByUser
      _orders = await _orderStatusApi.getOrdersByUser(usersId); // userId cần được định nghĩa ở đâu đó trong widget tree
      // Sắp xếp danh sách đơn hàng theo thời gian tạo từ mới đến cũ
      _orders.sort((a, b) => b.createAt!.compareTo(a.createAt!));
    } catch (e) {
      print("Error fetching orders: $e");
    } finally {
      // Đánh dấu đã tải xong dữ liệu
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final List<Order> filteredOrders = _orders.where((order) => order.orderStatusId == widget.statusId).toList();
    if (filteredOrders.isEmpty) {
      // Nếu không có đơn hàng, hiển thị hình ảnh hoặc biểu tượng phù hợp
      return const Center(
        child: Column(
          children: [
            Icon(Iconsax.box, size: 150, color: Colors.grey),
            SizedBox(height: 24),
            Text('Mục này đang trống', style: TextStyle(fontSize: 18, color: Colors.grey), textAlign: TextAlign.center,)
          ],
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredOrders.length,
      separatorBuilder: (_,__) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, index) => TRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: dark ? TColors.dark : TColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Row 1
            Row(
              children: [
                /// 1 - Icon
                const Icon(Iconsax.ship),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
      
                /// 2 - Status & date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Đang xử lý",
                      //   style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary, fontWeightDelta: 1),
                      // ),
                      Text(dateFormat.format(filteredOrders[index].createAt!), style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),
      
                /// 3 - Icon
                IconButton(
                  onPressed: () => Get.to(() => OrderDetailScreen(
                    orderDetail: filteredOrders[index],
                    name: customerDetail['firstName'] + ' ' + customerDetail['lastName'],
                    phoneNumber: customerDetail['phoneNumber'],
                  )), 
                  icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm)),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
      
            /// Row 2
            Row(
              children: [
                // Expanded(
                //   child: Row(
                //     children: [
                //       /// 1 - Icon
                //       const Icon(Iconsax.tag),
                //       const SizedBox(width: TSizes.spaceBtwItems / 2),
                  
                //       /// 2 - Status & date
                //       Expanded(
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text('Thứ tự', style: Theme.of(context).textTheme.labelMedium),
                //             Text('#${_orders[index].orderId.toString()}', style: Theme.of(context).textTheme.titleMedium),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
      
                Expanded(
                  child: Row(
                    children: [
                      /// 1 - Icon
                      const Icon(Iconsax.calendar),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),
                  
                      /// 2 - Status & date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ngày giao', style: Theme.of(context).textTheme.labelMedium),
                            Text('2 ngày sau khi đặt', style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                      ),
                    ],
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
