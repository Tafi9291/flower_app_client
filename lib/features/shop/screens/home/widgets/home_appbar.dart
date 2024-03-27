import 'package:flutter/material.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class THomeAppBar extends StatefulWidget {
  const THomeAppBar({super.key});

  @override
  State<THomeAppBar> createState() => _THomeAppBarState();
}

class _THomeAppBarState extends State<THomeAppBar> {

  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();

  Map<String, dynamic> customerDetail = {};

  @override
  void initState() {
    super.initState();
    loadcustomerDetail();
  }

  void loadcustomerDetail() async {
    try {
      final customerDetailResponse = await customerApiHandler.getUserDetail();
      setState(() {
        customerDetail = customerDetailResponse;
      });
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17.0),
      child: TAppBar(title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.dark)),
            Text('${customerDetail['firstName']} ${customerDetail['lastName']}', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.dark)),
          ],
        ),
        actions: [
          TCartCounterIcon(onPressed: () {}, iconColor: Colors.black),
        ],
      ),
    );
  }
}
