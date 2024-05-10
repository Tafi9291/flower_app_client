import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/order/widgets/orders_list.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TOrderTab extends StatefulWidget {
  const TOrderTab({super.key, required this.status, required this.statusId});

  final String status;
  final int statusId;

  @override
  State<TOrderTab> createState() => _TOrderTabState();
}

class _TOrderTabState extends State<TOrderTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: TSizes.spaceBtwItems,),
        
              /// Product
              TSectionHeading(title: widget.status, onPressed: (){}, showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),
        
              // TGridLayout(
              //   itemCount: 4,
              //   itemBuilder: (_, index) => const TOrderListItems(),
              // ),
              TOrderListItems(statusId: widget.statusId,),
            ],
          ),
        )
      ],
    );
  }
}