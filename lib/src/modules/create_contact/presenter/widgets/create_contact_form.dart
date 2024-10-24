import 'package:app_piloto/core/components/widgets/input_formatter.dart';
import 'package:app_piloto/src/modules/create_contact/presenter/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateContactForm extends StatefulWidget {
  final TextEditingController nameUserController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final bool? readOnly;

  const CreateContactForm({
    super.key,
    required this.nameUserController,
    required this.phoneController,
    required this.emailController,
    this.readOnly,
  });

  @override
  State<CreateContactForm> createState() => _CreateContactFormState();
}

class _CreateContactFormState extends State<CreateContactForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        CreateContactItem(
          controller: widget.nameUserController,
          text: 'Nome',
          icon: Icons.account_circle_outlined,
          readOnly: widget.readOnly,
          listTextInputFormatter: [
            AppPilotoMaskTextInputFormatters.nameTextFormatter,
            LengthLimitingTextInputFormatter(20),
          ],
        ),
        const SizedBox(height: 10),
        CreateContactItem(
          controller: widget.phoneController,
          text: 'Telefone',
          icon: Icons.phone,
          readOnly: widget.readOnly,
          listTextInputFormatter: [
            AppPilotoMaskTextInputFormatters.phoneTextFormatter,
            LengthLimitingTextInputFormatter(20),
          ],
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 10),
        CreateContactItem(
          controller: widget.emailController,
          text: 'E-mail',
          icon: Icons.email,
          readOnly: widget.readOnly,
          listTextInputFormatter: [
            AppPilotoMaskTextInputFormatters.emailTextFormatter,
            LengthLimitingTextInputFormatter(20),
          ],
        ),
      ],
    );
  }
}
