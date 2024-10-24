import 'dart:ui';

import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/index.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:app_piloto/src/modules/favorites/domain/erros.dart';
import 'package:app_piloto/src/modules/favorites/presenter/favorites_cubit/favorites_cubit.dart';
import 'package:app_piloto/src/modules/favorites/presenter/index.dart';
import 'package:app_piloto/src/modules/home/presenter/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPilotoModal {
  Future<void> showErrorModal(BuildContext context, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(45))),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.error,
                  color: AppPilotoColors().red(),
                  size: 48,
                ),
                const SizedBox(height: 15),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    color: AppPilotoColors().black(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Align(
              alignment: AlignmentDirectional.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    AppPilotoColors().purple(),
                  ),
                ),
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: AppPilotoColors().white(),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showSuccessModal(BuildContext context, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(45))),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: AppPilotoColors().green(),
                  size: 48,
                ),
                const SizedBox(height: 15),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppPilotoColors().black(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                padding: EdgeInsets.zero,
                width: MediaQuery.sizeOf(context).width * 16,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      AppPilotoColors().purple(),
                    ),
                  ),
                  child: Text(
                    'Ok',
                    style: GoogleFonts.comfortaa(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppPilotoColors().white(),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showConfirmModal(BuildContext context, String text, Function()? onPressed, Icon iconData) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(45))),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                iconData,
                const SizedBox(height: 15),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w700, color: AppPilotoColors().black()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                padding: EdgeInsets.zero,
                width: MediaQuery.sizeOf(context).width * 16,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        AppPilotoColors().purple(),
                      ),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      'Sim',
                      style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w700, color: AppPilotoColors().white()),
                    )),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                padding: EdgeInsets.zero,
                width: MediaQuery.sizeOf(context).width * 16,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      AppPilotoColors().purple(),
                    ),
                  ),
                  child: Text(
                    'Não',
                    style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w700, color: AppPilotoColors().white()),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showGenericModal(BuildContext context, String text, Function()? onPressed, Icon iconData, bool hasSecondButton, String textButton, String? textSecondButton) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(45))),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                iconData,
                const SizedBox(height: 15),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w700, color: AppPilotoColors().black()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                padding: EdgeInsets.zero,
                width: MediaQuery.sizeOf(context).width * 16,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        AppPilotoColors().purple(),
                      ),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      textButton,
                      style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w700, color: AppPilotoColors().white()),
                    )),
              ),
            ),
            const SizedBox(height: 8),
            hasSecondButton
                ? Align(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: MediaQuery.sizeOf(context).width * 16,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            AppPilotoColors().purple(),
                          ),
                        ),
                        child: Text(
                          textSecondButton ?? '',
                          style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w700, color: AppPilotoColors().white()),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        );
      },
    );
  }

  static Future showWidgetWrapperModal(BuildContext context, Widget child, {bool dismissible = true}) async {
    return showGeneralDialog(
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(opacity: anim1, child: child),
      ),
      context: context,
      barrierDismissible: dismissible,
      barrierLabel: '',
      barrierColor: Colors.black26,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Wrap(
          alignment: WrapAlignment.center,
          children: [child],
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Future<void> showContact({required BuildContext context, bool dismissible = true, required ContactModel contactModel}) async {
    ContactListCubit contactCubit = I.getDependency<ContactListCubit>();
    FavoritesCubit favoritosCubit = I.getDependency<FavoritesCubit>();
    return showWidgetWrapperModal(
      context,
      dismissible: dismissible,
      Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 42,
                backgroundImage: AssetImage('images/user.png'),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppPilotoColors().purple(),
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              child: Column(
                children: [
                  CreateContactForm(
                      emailController: TextEditingController(text: contactModel.email),
                      nameUserController: TextEditingController(text: contactModel.nameUser),
                      phoneController: TextEditingController(text: contactModel.phone),
                      readOnly: true)
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 48,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    AppPilotoModal().showConfirmModal(context, 'Gostaria de excluir este contato? ', () {
                      contactCubit.deleteContact(contactModel.nameUser);
                    }, Icon(Icons.warning, color: AppPilotoColors().yellow(), size: 48));
                  },
                  icon: Icon(Icons.delete_outline_outlined, color: AppPilotoColors().purple()),
                ),
                const SizedBox(width: 24),
                IconButton(
                  iconSize: 48,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                 favoritosCubit.insertFavorite(contactModel);
                    AppPilotoModal().showGenericModal(context, 'Eba! Contato favoritado com sucesso!', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesScreen()));
                    }, Icon(Icons.auto_awesome_outlined, color: AppPilotoColors().purple(), size: 48), false, 'Ok', '');
                  },
                  icon: Icon(Icons.favorite_outline_sharp, color: AppPilotoColors().purple()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
