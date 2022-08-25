import 'package:flutter/material.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/core/widgets/custom_app_bar.dart';
import 'package:flutter101/core/widgets/header.dart';
import 'package:flutter101/src/pages/main/widgets/main_content.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Header(headLine1:"Our",headLine2:"Products"),
            Expanded(child: MainContent()),
          ],
        ),
      ),
    );
  }
}
