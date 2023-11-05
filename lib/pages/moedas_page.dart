import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/pages/moedas_detalhes_page.dart';
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

  AppBar customAppBar() {
    return moedasSelecionadas.isEmpty
        ? AppBar(
            title: const Text("Cripto Moedas"),
            actions: [
              IconButton(
                padding: const EdgeInsets.only(right: 12),
                onPressed: () => setState(() {
                  moedasRepository.sort();
                }),
                icon: const Icon(
                  Icons.swap_vert_circle,
                  size: 32,
                ),
              ),
            ],
          )
        : AppBar(
            backgroundColor: Colors.blueGrey[400],
            title: moedasSelecionadas.length == 1
                ? const Text("1 selecionada")
                : Text("${moedasSelecionadas.length} selecionadas"),
            leading: IconButton(
              padding: const EdgeInsets.only(left: 12),
              icon: const Icon(
                Icons.cancel_rounded,
                size: 32,
              ),
              onPressed: () {
                setState(() {
                  moedasSelecionadas.clear();
                });
              },
            ),
            actions: [
              IconButton(
                padding: const EdgeInsets.only(right: 12),
                onPressed: () => setState(() {
                  moedasRepository.sort();
                }),
                icon: const Icon(
                  Icons.swap_vert_circle,
                  size: 32,
                ),
              ),
            ],
          );
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoedasDetalhesPage(moeda: moeda),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      floatingActionButton: moedasSelecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Favoritar"),
              icon: const Icon(Icons.favorite),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, moeda) {
          return ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            onTap: () {
              if (moedasSelecionadas.isNotEmpty) {
                setState(() {
                  moedasSelecionadas.contains(tabela[moeda])
                      ? moedasSelecionadas.remove(tabela[moeda])
                      : moedasSelecionadas.add(tabela[moeda]);
                });
              } else {
                mostrarDetalhes(tabela[moeda]);
              }
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
              // print('${tabela[moeda].nome} alterada na listsa');
            },
          );
        },
        padding: const EdgeInsets.all(16.0),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: tabela.length,
      ),
      // bottomSheet: SizedBox(
      //   width: MediaQuery.of(context).size.width,
      //   height: 80,
      //   child: ElevatedButton(
      //     child: const Text("Press me"),
      //     onPressed: () {},
      //   ),
      // ),
    );
  }
}
