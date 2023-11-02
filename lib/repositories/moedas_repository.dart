import 'package:cripto_moedas/models/moeda.dart';

class MoedasRepository {

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
  


}
