import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileContact extends StatefulWidget {
  final String nameUser;
  final String phone;

  const ListTileContact({required this.nameUser, required this.phone, super.key});

  @override
  State<ListTileContact> createState() => _ListTileContactState();
}

class _ListTileContactState extends State<ListTileContact> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 8, top: 0, right: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            isObscure ? widget.nameUser.replaceAll(RegExp(r"."), "*") : widget.nameUser,
            textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppPilotoColors().white(),
            ),
          ),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8, right: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            isObscure ? widget.phone.replaceAll(RegExp(r"."), "*") : widget.phone,
            textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppPilotoColors().white(),
            ),
          ),
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        icon: isObscure ? Icon(Icons.visibility_off, color: AppPilotoColors().white()) : Icon(Icons.visibility, color: AppPilotoColors().white()),
      ),
      leading: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage('images/user.png'),
        ),
      ),
    );
  }
}
