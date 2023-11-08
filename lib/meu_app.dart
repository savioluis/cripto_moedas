import 'package:cripto_moedas/pages/auth/auth_page.dart';
import 'package:cripto_moedas/pages/auth/auth_page_controller.dart';
import 'package:cripto_moedas/pages/moedas/home/moedas_page.dart';
import 'package:flutter/material.dart';

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cripto Moedas",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: AuthPage(controller: AuthPageController()),
    );
  }
}
