import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/utils/snack_bar_util.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static desfavoritarDialog(
    BuildContext context,
    MoedaModel moeda,
    Function() onPressed,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text("Aviso"),
          content: Text("Deseja remover ${moeda.nome} dos favoritos ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                onPressed();
                Navigator.pop(context);
                Navigator.pop(context);
                SnackBarUtil.infoSnackBar(context, 'Lista atualizada');
              },
              child: const Text("Remover"),
            ),
          ],
        );
      },
    );
  }
}
