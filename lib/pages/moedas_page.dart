import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/repositories/moedas_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> moedasSelecionadas = [];
  List<Moeda> tabela = MoedasRepository.tabela;
  final moedasRepository = MoedasRepository();

  @override
  void initState() {
    super.initState();
    moedasRepository.sort();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cripto Moedas"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () => setState(() {
                moedasRepository.sort();
              }),
              icon: const Icon(
                Icons.swap_vert_circle,
                size: 32,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, moeda) {
          return ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            onTap: () {
              print(moedasSelecionadas);
            },
            leading: (moedasSelecionadas.contains(tabela[moeda]))
                ? const SizedBox(
                    width: 48,
                    child: CircleAvatar(
                      child: Icon(Icons.check),
                    ),
                  )
                : SizedBox(
                    height: 48,
                    child: Image.asset(
                      tabela[moeda].icone,
                    ),
                  ),
            title: Text(
              tabela[moeda].nome,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              real.format(tabela[moeda].preco),
            ),
            selected: moedasSelecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                moedasSelecionadas.contains(tabela[moeda])
                    ? moedasSelecionadas.remove(tabela[moeda])
                    : moedasSelecionadas.add(tabela[moeda]);
              });
              print('${tabela[moeda].nome} alterada na listsa');
            },
          );
        },
        padding: const EdgeInsets.all(16.0),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: tabela.length,
      ),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: ElevatedButton(
          child: const Text("Press me"),
          onPressed: () {},
        ),
      ),
    );
  }
}
