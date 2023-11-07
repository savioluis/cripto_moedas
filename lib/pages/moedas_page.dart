import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/pages/moedas_detalhes_page.dart';
import 'package:cripto_moedas/repositories/coins_repository.dart';
import 'package:cripto_moedas/services/http_provider.dart';
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
  List<Moeda> tabela = [];
  bool isLoading = true;
  bool isSorted = false;

  CoinsRepository coinsRepository = CoinsRepositoryImpl(HttpProvider());
  List<Moeda> moedasSelecionadas = [];
  List<Moeda> favoriteCoins = [];

  Future<void> loadData() async {
    tabela = await coinsRepository.infoAllCoins();
    setState(() {
      isLoading = false;
    });
  }

  void sortCoins() {
    if (!isSorted) {
      setState(() {
        tabela.sort((Moeda a, Moeda b) => a.preco.compareTo(b.preco));
      });
    } else {
      setState(() {
        tabela = tabela.reversed.toList();
      });
    }
    isSorted = !isSorted;
  }

  void favoritar(List<Moeda> moedas) {
    setState(() {
      for (var moeda in moedas) {
        if (!favoriteCoins.contains(moeda)) {
          favoriteCoins.add(moeda);
        }
      }
      moedasSelecionadas.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Lista de favoritos atualizada com sucesso"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  AppBar customAppBar() {
    return moedasSelecionadas.isEmpty
        ? AppBar(
            title: const Text("Cripto Moedas"),
            actions: [
              IconButton(
                padding: const EdgeInsets.only(right: 12),
                onPressed: () => sortCoins(),
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
                onPressed: () => sortCoins(),
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
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: customAppBar(),
            drawer: Drawer(
              child: ListView(
                children: [
                  const UserAccountsDrawerHeader(
                    accountName: Text('nome'),
                    accountEmail: Text('email'),
                    currentAccountPicture: CircleAvatar(),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      size: 48,
                    ),
                    title: Text(
                      "Moedas Favoritas",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Divider(),
                  ListView.separated(
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
                                image: NetworkImage(favoriteCoins[moeda].icone),
                              ),
                            ),
                          ),
                          title: Text(favoriteCoins[moeda].nome),
                          onTap: () {
                            Navigator.pop(context);
                            mostrarDetalhes(favoriteCoins[moeda]);
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Aviso"),
                                  content: Text(
                                      "Deseja remover ${favoriteCoins[moeda].nome} dos favoritos ?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancelar"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          favoriteCoins
                                              .remove(favoriteCoins[moeda]);
                                        });
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("A lista foi atualizada"),
                                          ),
                                        );
                                      },
                                      child: const Text("Remover"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: favoriteCoins.length)
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
