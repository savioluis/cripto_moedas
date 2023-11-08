// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cripto_moedas/widgets/custom_text_form_field.dart';
import 'package:cripto_moedas/widgets/full_width_button.dart';
import 'package:flutter/material.dart';

import 'package:cripto_moedas/pages/auth/auth_page_controller.dart';

class AuthPage extends StatefulWidget {
  final AuthPageController controller;

  const AuthPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  void dispose() {
    super.dispose();
    widget.controller.usuarioController.dispose();
    widget.controller.senhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: widget.controller.formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: const Column(
                children: [
                  Icon(
                    Icons.monetization_on,
                    size: 96,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    "CRIPTO",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomTextFormField(
                controller: widget.controller.usuarioController,
                text: "Usuário",
                prefixIcon: const Icon(Icons.person),
                validator: (input) {
                  if (input!.isEmpty) {
                    return "Preencha o campo com dados validos";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomTextFormField(
                controller: widget.controller.senhaController,
                text: "Senha",
                validator: (input) {
                  return input!.isEmpty
                      ? "Preencha o campo com dados validos"
                      : null;
                },
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: widget.controller.senhaEscondida
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    setState(() {
                      widget.controller.mostrarSenha();
                    });
                  },
                ),
                obscureText: widget.controller.senhaEscondida,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FullWidthButton(
                text: "Login",
                onPressed: () => widget.controller.login(context),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
