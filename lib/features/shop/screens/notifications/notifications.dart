import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/screens/notifications/widgets/notification_item.dart';
import 'package:t_store/utils/constants/sizes.dart';

class NotificationsSrceen extends StatefulWidget {
  const NotificationsSrceen({super.key});

  @override
  State<NotificationsSrceen> createState() => _NotificationsSrceenState();
}

class _NotificationsSrceenState extends State<NotificationsSrceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        actions: const [Icon(Iconsax.notification)],
        title: Text('Thông báo', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ListView.builder(
                itemCount: 10, // Số lượng mục
                shrinkWrap: true, // Đặt shrinkWrap thành true để thu gọn ListView theo chiều dọc
                physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn tự động của ListView
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems), // Đặt padding giữa các mục
                    child: TNotificationItem(), // Widget mục thông báo
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}