import 'package:cripto_moedas/meu_app.dart';
import 'package:cripto_moedas/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritasRepository(),
      child: const MeuApp(),
    ),
  );
}
