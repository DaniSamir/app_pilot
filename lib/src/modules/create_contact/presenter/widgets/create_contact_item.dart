import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateContactItem extends StatefulWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? listTextInputFormatter;
  final IconData icon;
  final String text;
  final TextInputType? keyboardType;
  final bool? readOnly;

  const CreateContactItem({
    required this.controller,
    this.listTextInputFormatter,
    required this.icon,
    required this.text,
    this.keyboardType,
    this.readOnly = false,
    super.key,
  });

  @override
  State<CreateContactItem> createState() => _CreateContactItemState();
}

class _CreateContactItemState extends State<CreateContactItem> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.readOnly ?? false,
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
