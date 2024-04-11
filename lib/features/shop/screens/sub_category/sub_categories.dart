import 'package:flutter/material.dart';
import 'package:t_store/admin/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/layouts/gird_layouts.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Hoa sinh nhật'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const TRoundedImage(width: double.infinity, imageUrl: TImages.bannerHoa, applyImageRadius: true),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Sub - categories
              Column(
                children: [
                  /// Heading
                  TSectionHeading(title: 'Sản phẩm bán chạy', onPressed: (){}, showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  Container(
                    padding: const EdgeInsets.only(left: 2, top: 5, bottom: 5, right: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Định dạng border
                      borderRadius: BorderRadius.circular(10.0), // Định dạng bo góc
                      
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 150,
                        child: ListView.separated(
                          itemCount: 4,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
                          itemBuilder: (context, index) => const TProductCardHorizontal(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(title: 'Sản phẩm bán chạy', onPressed: (){}, showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TGridLayout(itemCount: 6, itemBuilder: (_, index) => const TProductCardVertical()),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}