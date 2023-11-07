import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/services/http_provider.dart';
import 'package:dio/dio.dart';

abstract class MoedasRepository {
  Future<List<MoedaModel>> infoAllCoins();
  Future<MoedaModel> getCoin(String coin);
}

class MoedasRepositoryImpl extends MoedasRepository {
  bool isSorted = false;
  final HttpProvider provider;

  MoedasRepositoryImpl(this.provider);

  @override
  Future<MoedaModel> getCoin(String coin) {
    throw UnimplementedError();
  }

  @override
  Future<List<MoedaModel>> infoAllCoins() async {
    final allCoinsString = await _searchAllCoins();
    final List<MoedaModel> moedas = [];
    try {
      var request = await provider.get(
        '?',
        queryParameters: {"coin": allCoinsString},
      );
      for (var coin in request.data["coins"]) {
        moedas.add(MoedaModel.fromMap(coin));
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
