import 'package:flutter/material.dart';

class FormularioReporte {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool esValido() {
    return formKey.currentState?.validate() ?? false;
  }

  void reset() {
    formKey.currentState?.reset();
  }

  void fijarInput(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
