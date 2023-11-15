import 'package:cripto_moedas/repositories/favoritas_repository.dart';
import 'package:cripto_moedas/widgets/moeda_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoedasFavoritasPage extends StatefulWidget {
  const MoedasFavoritasPage({super.key});

  @override
  State<MoedasFavoritasPage> createState() => _MoedasFavoritasPageState();
}

class _MoedasFavoritasPageState extends State<MoedasFavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moedas Favoritas Page"),
      ),
      body: ListView(
        // height: MediaQuery.of(context).size.height,
        // color: Colors.blueGrey.withOpacity(0.05),
        children: [Consumer<FavoritasRepository>(
          builder: (context, favoritas, child) {
            return favoritas.lista.isEmpty
                ? const ListTile(
                    leading: Icon(Icons.favorite_border_outlined),
                    title: Text("Ainda nao ha moedas favoritas"),
                  )
                : ListView.separated(
                  shrinkWrap: true,
                    itemCount: favoritas.lista.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(0),
                        child: MoedaCard(moeda: favoritas.lista[index]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  );
          },
        ),]
      ),
    );
  }
}

// ListTile(
//                         leading: CircleAvatar(
//                             child: Image.asset(favoritas.lista[index].icone)),
//                         title: Text(favoritas.lista[index].nome),
//                         trailing: Text(favoritas.lista[index].preco.toString()),
//                       );