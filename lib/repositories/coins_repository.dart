import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/services/http_provider.dart';
import 'package:dio/dio.dart';

abstract class CoinsRepository {
  Future<String> _searchAllCoins();
  Future<List<Moeda>> infoAllCoins();
  Future<Moeda> getCoin(String coin);
}

class CoinsRepositoryImpl extends CoinsRepository {
  bool isSorted = false;
  final HttpProvider provider;

  CoinsRepositoryImpl(this.provider);

  @override
  Future<Moeda> getCoin(String coin) {
    throw UnimplementedError();
  }

  @override
  Future<List<Moeda>> infoAllCoins() async {
    final allCoinsString = await _searchAllCoins();
    final List<Moeda> moedas = [];
    try {
      var request = await provider.get(
        '?',
        queryParameters: {"coin": allCoinsString},
      );
      for (var coin in request.data["coins"]) {
        moedas.add(Moeda.fromMap(coin));
      }
      // print(moedas);
      // return (request.data["coins"] as List)
      //     .map((coin) => Moeda.fromMap(coin))
      //     .toList();
      return moedas;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> _searchAllCoins() async {
    String allCoins = "";
    try {
      var request = await provider.get(
        '/available?',
        queryParameters: {"token": "eJGEyu8vVHctULdVdHYzQd"},
      );
      for (var i = 0; i < request.data["coins"].length; i++) {
        allCoins += i == request.data["coins"].length - 1
            ? request.data["coins"][i]
            : request.data["coins"][i] + ",";
      }
      return allCoins;
    } on DioException catch (e) {
      rethrow;
    }
  }

}
