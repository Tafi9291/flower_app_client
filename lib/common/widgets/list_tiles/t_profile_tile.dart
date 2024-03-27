import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class TUserProfileTile extends StatefulWidget {
  const TUserProfileTile({super.key, required this.onPressed,});

  final VoidCallback onPressed;

  @override
  State<TUserProfileTile> createState() => _TUserProfileTileState();
}

class _TUserProfileTileState extends State<TUserProfileTile> {

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
    return ListTile(
      leading: const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0,),
      title: Text('${customerDetail['nickName']}', style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.dark)),
      subtitle: Text('${customerDetail['email']}', style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.dark)),
      trailing: IconButton(onPressed: widget.onPressed, icon: const Icon(Iconsax.edit, color: TColors.dark,),),
      
    );
  }
}