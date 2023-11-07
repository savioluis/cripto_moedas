// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MoedaModel {
  String nome;
  String sigla;
  String icone;
  double preco;

  MoedaModel({
    required this.nome,
    required this.sigla,
    required this.icone,
    required this.preco,
  });

  @override
  String toString() {
    return 'Moeda (nome: $nome, sigla: $sigla, preco: $preco)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'sigla': sigla,
      'icone': icone,
      'preco': preco,
    };
  }

  factory MoedaModel.fromMap(Map<String, dynamic> map) {
    return MoedaModel(
      nome: map['coinName'].toString().substring(0, map['coinName'].length-3),
      sigla: map['coin'] as String,
      icone: map['coinImageUrl'] as String,
      preco: map['regularMarketPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoedaModel.fromJson(String source) => MoedaModel.fromMap(json.decode(source) as Map<String, dynamic>);

}
