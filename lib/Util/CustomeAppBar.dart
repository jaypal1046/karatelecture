import 'package:flutter/material.dart';
import 'package:karate_lecture/Widget/OurAppBar.dart';
class CustomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final List<Widget> action;
  const CustomeAppBar({Key key,@required this.title,@required this.action}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return OurAppBar(
      centerTitle: true,

      title: title is String?Text(title,style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),):
      title,
      action: action,
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+10);
}
