import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemContactUs,
    itemShare,
    itemRateApp,
 ];
 
  static const itemContactUs = MenuItem(
    text: 'Contact Us',
    icon: Icons.email,
  );

  static const itemShare = MenuItem(
    text: 'Share',
    icon: Icons.share,
  );

  static const itemRateApp = MenuItem(
    text: 'Rate App',
    icon: Icons.star,
  );
}
