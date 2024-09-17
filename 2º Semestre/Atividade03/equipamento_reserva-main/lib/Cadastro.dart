import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cadastro extends StatefulWidget {
  @override
  _CadastroEquipamentoPageState createState() =>
      _CadastroEquipamentoPageState();
}

class _CadastroEquipamentoPageState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  Future<void> _cadastrarEquipamento() async {
    final nome = _nomeController.text;

    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/equipamentos'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'nome': nome, 'disponivel': false}),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Equipamento cadastrado com sucesso!'),
          ));
          Navigator.pop(context);
        } else {
          _handleError(
              'Falha ao cadastrar equipamento. Código de status: ${response.statusCode}');
        }
      } catch (e) {
        _handleError('Erro ao cadastrar equipamento: $e');
      }
    }
  }

  void _handleError(String message) {
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Equipamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration:
                    const InputDecoration(labelText: 'Nome do Equipamento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do equipamento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _cadastrarEquipamento,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
