import 'package:t_store/admin/common/widgets/appbar/appbar.dart';
import 'package:t_store/admin/common/widgets/appbar/tabbar.dart';
import 'package:t_store/admin/featured/orders/widgets/order_tab.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          leadingIcon: Icons.menu, 
          leadingOnPressed: (){Scaffold.of(context).openDrawer();}, 
          title: const Text('Đơn hàng'),
        ),
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
                bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('Đang xử lý', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),),
                    Tab(child: Text('Đã xử lý', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                    Tab(child: Text('Đang giao', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                    Tab(child: Text('Đã giao', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                    Tab(child: Text('Đơn hủy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
            ];
      
            /// Body
          }, 
          body: const TabBarView(
            children: [
              TOrderTab(),
              TOrderTab(),
              TOrderTab(),
              TOrderTab(),
              TOrderTab(),
            ],
          ),
        ),
      ),
    );
  }
}