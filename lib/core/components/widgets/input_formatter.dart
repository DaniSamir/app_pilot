import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppPilotoMaskTextInputFormatters {
  static final MaskTextInputFormatter phoneTextFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static final MaskTextInputFormatter nameTextFormatter = MaskTextInputFormatter(
    filter: {"#": RegExp(r"^[a-zA-Z]+(([',.-][a-zA-Z ])?[a-zA-Z]*)*$")},
  );

  static final MaskTextInputFormatter emailTextFormatter = MaskTextInputFormatter(
    filter: {"#": RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")},
  );
}
