import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterStore extends StatefulWidget {
  @override
  _RegisterStoreState createState() => _RegisterStoreState();
}

class _RegisterStoreState extends State<RegisterStore> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _localidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();

  Future<void> _registerStore() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://localhost:5095/Stores/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'type': _typeController.text,
          'cep': _cepController.text,
          'logradouro': _logradouroController.text,
          'bairro': _bairroController.text,
          'localidade': _localidadeController.text,
          'uf': _ufController.text,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loja registrada com sucesso!')),
        );

        _clearFields();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Erro ao registrar loja: ${response.reasonPhrase}')),
        );
      }
    }
  }

  void _clearFields() {
    _nameController.clear();
    _typeController.clear();
    _cepController.clear();
    _logradouroController.clear();
    _bairroController.clear();
    _localidadeController.clear();
    _ufController.clear();
  }

  Future<void> _fetchAddress() async {
    final cep = _cepController.text;
    final response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      final addressData = json.decode(response.body);
      if (addressData['erro'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CEP não encontrado.')),
        );
        return;
      }

      _logradouroController.text = addressData['logradouro'] ?? '';
      _bairroController.text = addressData['bairro'] ?? '';
      _localidadeController.text = addressData['localidade'] ?? '';
      _ufController.text = addressData['uf'] ?? '';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erro ao buscar endereço: ${response.reasonPhrase}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Loja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome da Loja'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da loja';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Tipo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o tipo da loja';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cepController,
                      decoration: const InputDecoration(labelText: 'CEP'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o CEP';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _fetchAddress,
                    tooltip: 'Buscar Endereço',
                  ),
                ],
              ),
              TextFormField(
                controller: _logradouroController,
                decoration: const InputDecoration(labelText: 'Logradouro'),
                readOnly: true,
              ),
              TextFormField(
                controller: _bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
                readOnly: true,
              ),
              TextFormField(
                controller: _localidadeController,
                decoration: const InputDecoration(labelText: 'Localidade'),
                readOnly: true,
              ),
              TextFormField(
                controller: _ufController,
                decoration: const InputDecoration(labelText: 'UF'),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _registerStore,
                    child: const Text('Salvar'),
                  ),
                  ElevatedButton(
                    onPressed: _clearFields,
                    child: const Text('Limpar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
