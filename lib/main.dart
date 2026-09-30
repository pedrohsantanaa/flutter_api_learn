import 'dart:convert'; // Converte JSON para Map

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// Aplicação principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConsultaCepPage(),
    );
  }
}

// Tela de consulta
class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  // Campo onde o usuário digita o CEP
  TextEditingController cepController = TextEditingController();

  // Variável que armazenará o endereço
  String resultado = "";

  // Função que consulta o ViaCEP
  Future<void> consultarCep() async {
    // Obtém o CEP digitado
    String cep = cepController.text;

    // Monta a URL da API
    String url = "https://viacep.com.br/ws/$cep/json/";

    // Faz a requisição
    var response = await http.get(Uri.parse(url));

    // Converte o JSON para Map
    Map dados = jsonDecode(response.body);

    // Atualiza a tela
    setState(() {
      resultado =
          "Logradouro: ${dados['logradouro']}\n"
          "Bairro: ${dados['bairro']}\n"
          "Cidade: ${dados['localidade']}\n"
          "UF: ${dados['uf']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consulta CEP")),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // Campo para digitar o CEP
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Digite o CEP",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Botão para consultar
            ElevatedButton(
              onPressed: consultarCep,
              child: const Text("Consultar"),
            ),

            const SizedBox(height: 20),

            // Exibe o resultado
            Text(resultado, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
