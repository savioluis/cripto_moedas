import 'package:cripto_moedas/pages/home_page.dart';
import 'package:flutter/material.dart';

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cripto Moedas",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const MoedasPage(),
    );
  }
}
