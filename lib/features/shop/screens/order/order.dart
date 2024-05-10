import 'package:flutter/material.dart';
import 'package:t_store/api/order_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/data/models/OrderStatus.dart';
import 'package:t_store/features/shop/screens/order/widgets/order_tab.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  final OrderApiHandler _orderStatusApi = OrderApiHandler();
  List<OrderStatus> _orderStatusList = [];

  @override
  void initState() {
    super.initState();
    _getOrderStatus();
  }

  Future<void> _getOrderStatus() async {
    try {
      List<OrderStatus> orderStatusList = await _orderStatusApi.getOrderStatus();
      setState(() {
        _orderStatusList = orderStatusList;
      });
    } catch (e) {
      print('Error fetching order status: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _orderStatusList.length,
      child: Scaffold(
        /// AppBar
        appBar: TAppBar(title: Text('Đơn hàng của tôi', style: Theme.of(context).textTheme.headlineMedium), showBackArrow: true),
        body: NestedScrollView(headerSliverBuilder: (_, innerBoxScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
                expandedHeight: 75,
        
                // flexibleSpace: Padding(
                //   padding: const EdgeInsets.all(TSizes.defaultSpace),
                //   child: ListView(
                //     shrinkWrap: true,
                //     // physics: const NeverScrollableScrollPhysics(),
                //     children: const [
                //       /// Search bar
                //       SizedBox(height: TSizes.spaceBtwItems,),
                //       TSearchContainer(text: 'Tìm kiếm...', showBorder: true, showBackGround: false, padding: EdgeInsets.zero,),
                      
                //     ],
                //   ),
                // ),
      
                /// Tabs
                // bottom: const TTabBar(
                //   tabs: [
                //     Tab(child: Text('Đang xử lý', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),),
                //     Tab(child: Text('Đã xử lý', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                //     Tab(child: Text('Đang giao', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                //     Tab(child: Text('Đã giao', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                //     Tab(child: Text('Đơn hủy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                //   ],
                // ),
                bottom: _orderStatusList.isEmpty
                ? null // or any placeholder widget if you want to display something when the list is empty
                : TTabBar(
                  tabs: _orderStatusList.map((status) => Tab(
                    child: Text(status.orderStatus.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  )).toList(),
                ),
              ),
            ];
      
            /// Body
          },
          body: TabBarView(
            children: _orderStatusList.map((status) => TOrderTab(status: status.orderStatus.toString(), statusId: status.orderStatusId!,)).toList(),
          ),
          // body: const TabBarView(
          //   children: [
          //     TOrderTab(),
          //     TOrderTab(),
          //     TOrderTab(),
          //     TOrderTab(),
          //     TOrderTab(),
          //   ],
          // ),
        ),
      ),
    );
  }
}

