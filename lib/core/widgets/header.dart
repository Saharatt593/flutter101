import 'package:flutter/material.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/core/widgets/custom_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.headLine1, required this.headLine2}) : super(key: key);

  final String headLine1;
  final String headLine2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CustomAppBar(
          title: 'MainPage AppBar',
        ),
        _title(),
      ],
    );
  }

  Widget _title() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                headLine1,
                style: GoogleFonts.mulish(
                    fontSize: 27,
                    fontWeight: FontWeight.w400,
                    color: LightColor.titleTextColor),
              ),
              Text(
                headLine2,
                style: GoogleFonts.mulish(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: LightColor.titleTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
