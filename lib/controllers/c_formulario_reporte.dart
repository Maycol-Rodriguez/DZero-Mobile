import 'package:flutter/material.dart';

class FormularioReporte {
  GlobalKey<FormState> formReportKey = GlobalKey<FormState>();
  GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();
  GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();

  bool reporteEsValido() {
    return formReportKey.currentState?.validate() ?? false;
  }

  bool registroEsValido() {
    return formRegisterKey.currentState?.validate() ?? false;
  }

  bool loginEsValido() {
    return formLoginKey.currentState?.validate() ?? false;
  }

  void reset() {
    formLoginKey.currentState?.reset();
    formRegisterKey.currentState?.reset();
    formReportKey.currentState?.reset();
  }

  void fijarInput(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
