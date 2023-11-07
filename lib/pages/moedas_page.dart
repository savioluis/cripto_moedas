import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/pages/moedas_detalhes_page.dart';
import 'package:cripto_moedas/repositories/moedas_repository.dart';
import 'package:cripto_moedas/services/http_provider.dart';
import 'package:cripto_moedas/utils/dialog_util.dart';
import 'package:cripto_moedas/utils/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  NumberFormat real =
      NumberFormat.currency(locale: 'pt_BR', name: 'R\$', decimalDigits: 7);
  List<MoedaModel> tabela = [];

  bool isLoading = true;
  bool isSorted = false;

  final provider = HttpProvider();
  late MoedasRepository moedasRepository;

  List<MoedaModel> moedasSelecionadas = [];
  List<MoedaModel> moedasFavoritas = [];

  Future<void> loadData() async {
    tabela = await moedasRepository.infoAllCoins();
    setState(() {
      isLoading = false;
    });
  }

  void ordenarMoedas() {
    if (!isSorted) {
      setState(() {
        tabela.sort((MoedaModel a, MoedaModel b) => a.preco.compareTo(b.preco));
      });
    } else {
      setState(() {
        tabela = tabela.reversed.toList();
      });
    }
    isSorted = !isSorted;
  }

  void favoritar(List<MoedaModel> moedas) {
    setState(() {
      for (var moeda in moedas) {
        if (!moedasFavoritas.contains(moeda)) {
          moedasFavoritas.add(moeda);
        }
      }
      moedasSelecionadas.clear();
    });
    SnackBarUtil.infoSnackBar(context, 'Lista de moedas favoritas atualizada');
  }

  void desfavoritar(MoedaModel moeda) {
    setState(() {
      moedasFavoritas.remove(moeda);
    });
  }

  @override
  void initState() {
    super.initState();
    moedasRepository = MoedasRepositoryImpl(provider);
    loadData();
  }

  AppBar customAppBar() {
    return moedasSelecionadas.isEmpty
        ? AppBar(
            title: const Text("Cripto Moedas"),
            actions: [
              IconButton(
                padding: const EdgeInsets.only(right: 12),
                onPressed: () => ordenarMoedas(),
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
                onPressed: () => ordenarMoedas(),
                icon: const Icon(
                  Icons.swap_vert_circle,
                  size: 32,
                ),
              ),
            ],
          );
  }

  void mostrarDetalhes(MoedaModel moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoedasDetalhesPage(moeda: moeda),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: customAppBar(),
            drawer: Drawer(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 32),
                    child: const Text(
                      "Moedas Favoritas",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
                    ),
                  ),
                  const Divider(),
                  moedasFavoritas.isEmpty
                      ? Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.25),
                          child: const Text(
                            "A lista esta vazia 😢",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, moeda) {
                            return ListTile(
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        moedasFavoritas[moeda].icone),
                                  ),
                                ),
                              ),
                              title: Text(moedasFavoritas[moeda].nome),
                              onTap: () {
                                Navigator.pop(context);
                                mostrarDetalhes(moedasFavoritas[moeda]);
                              },
                              onLongPress: () {
                                DialogUtil.desfavoritarDialog(
                                  context,
                                  moedasFavoritas[moeda],
                                  () => desfavoritar(moedasFavoritas[moeda]),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: moedasFavoritas.length)
                ],
              ),
            ),
            floatingActionButton: moedasSelecionadas.isNotEmpty
                ? FloatingActionButton.extended(
                    onPressed: () {
                      favoritar(moedasSelecionadas);
                    },
                    label: const Text("Favoritar"),
                    icon: const Icon(Icons.favorite),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, moeda) {
                return ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  leading: (moedasSelecionadas.contains(tabela[moeda]))
                      ? const SizedBox(
                          width: 48,
                          child: CircleAvatar(
                            child: Icon(Icons.check),
                          ),
                        )
                      : Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(tabela[moeda].icone),
                            ),
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
                  onLongPress: () {
                    setState(() {
                      moedasSelecionadas.contains(tabela[moeda])
                          ? moedasSelecionadas.remove(tabela[moeda])
                          : moedasSelecionadas.add(tabela[moeda]);
                    });
                  },
                );
              },
              padding: const EdgeInsets.all(16.0),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: tabela.length,
            ),
          );
  }
}
