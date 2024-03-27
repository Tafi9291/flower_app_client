import 'package:t_store/admin/common/widgets/appbar/appbar.dart';
import 'package:t_store/admin/common/widgets/products/sortable/sortable_products.dart';
import 'package:t_store/admin/featured/products/add_product.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        leadingIcon: Icons.menu, 
        leadingOnPressed: (){Scaffold.of(context).openDrawer();}, 
        title: const Text('Sản phẩm'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: TColors.primary,
            foregroundColor: Colors.black,
            onPressed: () => Get.to(() => const AddProductScreen()),
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: 4,
            //   itemBuilder: (BuildContext context, int index){
            //     return const Padding(
            //       padding: EdgeInsets.all(TSizes.md),
            //       child: TSortableProducts(),
            //     );
            //   },
            // ),
            Padding(
              padding: EdgeInsets.all(TSizes.md),
              child: TSortableProducts(),
            )
          ],
        ),
      ),
    );
  }
}