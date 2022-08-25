import 'package:flutter/material.dart';
import 'package:flutter101/core/widgets/header.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Header(headLine1: "Shopping", headLine2: "Cart"),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
