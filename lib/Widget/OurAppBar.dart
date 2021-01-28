import 'package:flutter/material.dart';
class OurAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> action;
  final Widget leading;
  final bool centerTitle;
  
  
  

  const OurAppBar({Key key, this.title, this.action,this.leading,this.centerTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.4,
            style: BorderStyle.solid,
          )
        )
      ),
      child: AppBar(
        elevation: 0,
        leading: leading,
        actions: action,
        centerTitle: centerTitle,
        title: title,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+10);
}
