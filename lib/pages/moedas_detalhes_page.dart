import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/utils/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoedasDetalhesPage extends StatefulWidget {
  final MoedaModel moeda;

  const MoedasDetalhesPage({
    super.key,
    required this.moeda,
  });

  @override
  State<MoedasDetalhesPage> createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  double quantidade = 0;

  void comprar() {
    if (_formKey.currentState!.validate()) {
      //Salvar compra

      Navigator.pop(context);
      SnackBarUtil.infoSnackBar(context,
          '$quantidade de ${widget.moeda.nome}foi comprada por ${real.format(double.parse(_controller.value.text))}');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(24.0),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 48,
                child: Image.network(widget.moeda.icone),
              ),
              const SizedBox(width: 10),
              Text(
                real.format(widget.moeda.preco),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: Colors.grey[800]),
              )
            ],
          ),
          const SizedBox(height: 24),
          quantidade > 0
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.05),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$quantidade',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          widget.moeda.sigla,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Valor',
                prefixIcon: const Icon(Icons.attach_money_rounded),
                suffix: const Text(
                  'reais',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value!.isEmpty) {
                  return "Preencha o campo com um valor valido";
                } else if (double.parse(value) < 10) {
                  return "Valor minimimo para compra eh 10 reais";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  quantidade = value.isEmpty
                      ? 0
                      : double.parse(value) / widget.moeda.preco;
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          // Container(
          //   margin: const EdgeInsets.only(top: 24),
          //   // width: MediaQuery.of(context).size.width,
          //   child: ElevatedButton(
          //     child: const Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(Icons.check),
          //         Padding(
          //           padding: EdgeInsets.all(16.0),
          //           child: Text(
          //             'Comprar',
          //             style: TextStyle(
          //               fontSize: 20,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     onPressed: () {
          //       comprar();
          //     },
          //   ),
          // )
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              icon: const Icon(Icons.check),
              label: const Text("Comprar"),
              onPressed: () {
                comprar();
              },
            ),
          ),
        ],
      ),
    );
  }
}
