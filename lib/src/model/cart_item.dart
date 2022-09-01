import 'package:flutter101/core/enum/available_color.dart';
import 'package:flutter101/core/enum/available_size.dart';
import 'package:flutter101/src/model/product.dart';

class CartItem{
  Product product;
  AvailableColor color;
  AvailableSize size;
  int quantity;
  bool isSelect;

  CartItem(this.product, this.color, this.size,{this.quantity =1,this.isSelect=false});
}