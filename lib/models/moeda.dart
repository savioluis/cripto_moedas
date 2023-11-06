// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Moeda {
  String nome;
  String sigla;
  String icone;
  double preco;

  Moeda({
    required this.nome,
    required this.sigla,
    required this.icone,
    required this.preco,
  });

  @override
  String toString() {
    return 'MOEDA (nome: $nome, sigla: $sigla, preco: $preco)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'sigla': sigla,
      'icone': icone,
      'preco': preco,
    };
  }

  factory Moeda.fromMap(Map<String, dynamic> map) {
    return Moeda(
      nome: map['coinName'].toString().substring(0, map['coinName'].length-3),
      sigla: map['coin'] as String,
      icone: map['coinImageUrl'] as String,
      preco: map['regularMarketPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Moeda.fromJson(String source) => Moeda.fromMap(json.decode(source) as Map<String, dynamic>);

}
