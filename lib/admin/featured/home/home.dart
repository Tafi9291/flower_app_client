import 'package:t_store/admin/common/widgets/appbar/appbar.dart';
import 'package:t_store/admin/common/widgets/home/home_card_vertical.dart';
import 'package:t_store/common/widgets/layouts/gird_layouts.dart';
import 'package:t_store/admin/common/widgets/notification/noti_icon.dart';
import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    // Tạo danh sách các màu để sử dụng cho các ô
  final List<Color> boxColors = [
    Colors.blue.shade200.withOpacity(0.5),
    Colors.green.shade200.withOpacity(0.5),
    Colors.orange.shade200.withOpacity(0.5),
    Colors.purple.shade200.withOpacity(0.5),
    Colors.red.shade200.withOpacity(0.5),
  ];

  final List<String>  titles = [
    'Phân loại',
    'Sản phẩm',
    'Đơn hàng',
    'Đơn hàng thành công',
    'Đơn hàng thất bại',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        leadingIcon: Icons.menu, 
        leadingOnPressed: (){Scaffold.of(context).openDrawer();},
        title: const Text('Trang chủ'),
        actions: [
          TNotiCounterIcon(onPressed: () {}, iconColor: Colors.black),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(itemCount: 5, mainAxisExtent: 170, itemBuilder: (_, index) => THomeCardVertical(
                  title: titles[index % titles.length],
                  backgroundColor: boxColors[index % boxColors.length],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}