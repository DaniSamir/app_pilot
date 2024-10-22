import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/src/modules/home/presenter/index.dart';
import 'package:flutter/material.dart';

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
                  size: 45,
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
                    AppPilotoColors().primary(),
                  ),
                ),
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: AppPilotoColors().white(),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashBoardScreen()),
                ),
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
                  color: AppPilotoColors().primary(),
                  size: 45,
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
                    AppPilotoColors().primary(),
                  ),
                ),
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: AppPilotoColors().white(),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashBoardScreen()),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
