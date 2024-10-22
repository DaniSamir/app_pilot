import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ShapeBorder kBackButtonShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);

Widget kBackBtn = Icon(
  Icons.arrow_back_ios,
  color: AppPilotoColors().black(),
);

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final double elevation;
  final List<Widget>? actions;
  bool? withCircle;

  CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.elevation = 2.0,
    this.withCircle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, 
      children: [
        Material(
          elevation: elevation,
          color: AppPilotoColors().orange(),
          child: AppBar(
            centerTitle: true,
            leading: leading,
            title: Padding(padding: const EdgeInsets.only(top: 10), child: title),
            backgroundColor: AppPilotoColors().orange(),
            actions: actions,
          ),
        ),
        if (withCircle!)
          Container(
            decoration: BoxDecoration(
              color: AppPilotoColors().orange(),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage('images/user.png'),
                ),
                const SizedBox(width: 15),
                Text(
                  'Usuário Teste',
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    color: AppPilotoColors().white(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => withCircle! ? const Size.fromHeight(120.0) : const Size.fromHeight(60.0);
}
