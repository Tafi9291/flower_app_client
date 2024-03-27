import 'package:t_store/admin/common/widgets/appbar/appbar.dart';
import 'package:t_store/admin/featured/notification/widgets/notification_item.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Thông báo'),
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