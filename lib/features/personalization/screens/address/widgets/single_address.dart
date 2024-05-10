import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TSingleAddress extends StatefulWidget {
  const TSingleAddress({super.key, required this.selectedAddress, this.address});

  final bool selectedAddress;

  final String? address;

  @override
  State<TSingleAddress> createState() => _TSingleAddressState();
}

class _TSingleAddressState extends State<TSingleAddress> {
  bool isChecked = false;

   @override
  void initState() {
    super.initState();
    isChecked = widget.selectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: widget.selectedAddress ? TColors.primary.withOpacity(0.5) : Colors.transparent,
      borderColor: widget.selectedAddress ? Colors.transparent : dark ? TColors.darkerGrey : TColors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(
        children: [
          // Positioned(
          //   right: 5,
          //   top: 0,
          //   child: Icon(
          //     widget.selectedAddress ? Iconsax.tick_circle5 : null,
          //     color: widget.selectedAddress ? dark ? TColors.light : TColors.dark.withOpacity(0.6) : null,
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Hà Vĩnh Tài',
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              // const SizedBox(height: TSizes.sm / 2),
              // const Text('(+84) 936188872', maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: TSizes.sm / 2),
              Text(widget.address.toString(), softWrap: true),
            ],
          ),
        ],
      ),
    );
  }
}
