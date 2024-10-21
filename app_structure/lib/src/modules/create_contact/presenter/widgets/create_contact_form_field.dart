import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateContactFormField extends StatefulWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? listTextInputFormatter;
  final IconData icon;
  final String text;
  final TextInputType? keyboardType;

  const CreateContactFormField({
    required this.controller,
    this.listTextInputFormatter,
    required this.icon,
    required this.text,
    this.keyboardType,
    super.key,
  });

  @override
  State<CreateContactFormField> createState() => _CreateContactFormFieldState();
}

class _CreateContactFormFieldState extends State<CreateContactFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
      child: TextFormField(
        controller: widget.controller,
        style: simpleTextStyle(),
        decoration: textFieldCustom(
          widget.text,
          Icon(
            widget.icon,
            color: AppPilotoColors().white(),
          ),
        ),
        inputFormatters: widget.listTextInputFormatter,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
