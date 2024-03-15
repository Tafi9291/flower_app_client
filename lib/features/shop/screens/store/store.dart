import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layouts/gird_layouts.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/features/shop/screens/brand/all_brands.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Danh mục', style: Theme.of(context).textTheme.headlineMedium,),
          actions: [
            TCartCounterIcon(onPressed: (){}, iconColor: TColors.dark),
          ],
        ),
        body: NestedScrollView(headerSliverBuilder: (_, innerBoxScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
              expandedHeight: 440,
      
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    /// Search bar
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    const TSearchContainer(text: 'Tìm kiếm...', showBorder: true, showBackGround: false, padding: EdgeInsets.zero,),
                    const SizedBox(height: TSizes.spaceBtwSections,),
      
                    /// Featured brands
                    TSectionHeading(title: 'Loại hoa phổ biến', onPressed: () => Get.to(() => const AllBrandsScreen())),
                    const SizedBox(height: TSizes.spaceBtwItems / 1.5),
      
                    /// Brands Grid
                    TGridLayout(itemCount: 4, mainAxisExtent: 80, itemBuilder: (_, index) {
                      return const TBrandCard(showBorder: true,);
                    }),
                    
                  ],
                ),
              ),

              /// Tabs
              bottom: const TTabBar(
                tabs: [
                  Tab(child: Text('Hoa Hồng')),
                  Tab(child: Text('Hoa Tulip')),
                  Tab(child: Text('Hoa Lily')),
                  Tab(child: Text('Hoa Lavender')),
                  Tab(child: Text('Hoa Cẩm Chướng')),
                ],
              ),
            ),
          ];

          /// Body
        }, body: const TabBarView(
          children: [
            TCategoryTab(),
            TCategoryTab(),
            TCategoryTab(),
            TCategoryTab(),
            TCategoryTab(),
          ],
        ),),
      ),
    );
  }
}






