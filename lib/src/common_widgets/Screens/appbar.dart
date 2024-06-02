import 'package:eduguard/src/common_widgets/controllers/navigation_drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title, this.showBackArrow =false, this.leadingIcon, this.actions, this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(NavigationDrawerController());

    return AppBar(
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (context) {
          return showBackArrow
              ? IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.keyboard_arrow_left_rounded, color: Colors.black,), iconSize: 28.0,)
              : IconButton(onPressed: () {controller.openNavigationDrawer();}, icon: const Icon(Icons.menu_rounded, color: Colors.black,), iconSize: 28.0,);
        },
      ),
      title: title,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
