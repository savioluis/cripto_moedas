import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/repositories/moedas_repository.dart';
import 'package:flutter/material.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final List<Moeda> tabela = MoedasRepository.tabela;


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cripto Moedas")),
      body: ListView.separated(
        itemBuilder: (context, moeda) {
          return ListTile(
            leading: Image.asset(tabela[moeda].icone),
            title: Text(tabela[moeda].nome),
            trailing: Text(tabela[moeda].preco.toString()),
          );
        },
        padding: const EdgeInsets.all(16.0),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: tabela.length,
      ),
    );
  }
}
