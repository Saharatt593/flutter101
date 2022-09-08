import 'package:flutter/material.dart';
import 'package:flutter101/core/config/routes.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/core/widgets/extentions.dart';
import 'package:get/route_manager.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(context, Icons.sort, color: Colors.black54),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            child: Image.asset(
              "assets/pin.png",
              width: 25,
              height: 25,
              color: LightColor.orange,
            ),
          ).ripple(() {
            Get.toNamed(Routes.nearbyStorePage);
          }, borderRadius: const BorderRadius.all(Radius.circular(13)))
        ],
      ),
    );
  }

  Widget _icon(BuildContext context, IconData icon,
      {Color color = LightColor.iconColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }
}
