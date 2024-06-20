import 'package:flutter/material.dart';
import 'package:todos_app/components/widgets.dart';
import 'package:todos_app/utils/color_palette.dart';
import 'package:todos_app/utils/font_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final List<Widget>? actionWidgets;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = kWhiteColor,
    this.actionWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: actionWidgets,
      title: Row(
        children: [
          buildText(
            title,
            kBlackColor,
            textMedium,
            FontWeight.w500,
            TextAlign.start,
            TextOverflow.clip,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
