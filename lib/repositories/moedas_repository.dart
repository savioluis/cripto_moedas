import 'package:cripto_moedas/models/moeda.dart';

class MoedasRepository {
  bool isSorted = false;

  static List<Moeda> tabela = [
    Moeda(
      nome: 'Bitcoin',
      sigla: 'BTC',
      icone: 'images/bitcoin.png',
      preco: 164603.00,
    ),
    Moeda(
      nome: 'Cardano',
      sigla: 'ADA',
      icone: 'images/cardano.png',
      preco: 6.32,
    ),
    Moeda(
      nome: 'Ethereum',
      sigla: 'ETH',
      icone: 'images/ethereum.png',
      preco: 9716.00,
    ),
    Moeda(
      nome: 'Litecoin',
      sigla: 'LTC',
      icone: 'images/litecoin.png',
      preco: 669.93,
    ),
    Moeda(
      nome: 'Dolar',
      sigla: 'USD',
      icone: 'images/usd.png',
      preco: 5.02,
    ),
    Moeda(
      nome: 'Xrp',
      sigla: 'XRP',
      icone: 'images/xrp.png',
      preco: 3.34,
    ),
  ];

  void sort() {
    if (!isSorted) {
      tabela.sort((Moeda a, Moeda b) => a.preco.compareTo(b.preco));
    } else {
      tabela.sort((Moeda a, Moeda b) => b.preco.compareTo(a.preco));
      // tabela = tabela.reversed.toList();
      // Por que nao atualiza se for uma reatribuicao, somente funciona se for em uma funcao void ?
    }
    isSorted = !isSorted;
  }
}
