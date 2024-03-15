import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/features/shop/screens/order/widgets/order_tab.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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