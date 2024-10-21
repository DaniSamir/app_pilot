import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:flutter/material.dart';

InputDecoration textFieldCustom(String labelText, Icon iconType) {
  return InputDecoration(
    //filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(
        20.0,
      )),
      borderSide: BorderSide(color: AppPilotoColors().white(), width: 4.0),
    ),

    focusedBorder:  OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: AppPilotoColors().white(), width: 2.0),
    ),
    prefixIcon: iconType,
    labelText: labelText,

    labelStyle:  TextStyle(
      fontSize: 16.0,
      color: AppPilotoColors().white(),
  ));
}

TextStyle simpleTextStyle() {
  return  TextStyle(
    fontSize: 17.0,
    color: AppPilotoColors().white(),
  );
}

RoundedRectangleBorder raisedButtonBorder() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0));
}
