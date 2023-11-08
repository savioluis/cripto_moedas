import 'package:cripto_moedas/utils/snack_bar_util.dart';
import 'package:flutter/material.dart';

class AuthPageController {
  final formKey = GlobalKey<FormState>();
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();
  
  bool senhaEscondida = true;

  void mostrarSenha() {
    senhaEscondida = !senhaEscondida;
  }

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      SnackBarUtil.infoSnackBar(context, "Sucesso !");
    }
  }
}
