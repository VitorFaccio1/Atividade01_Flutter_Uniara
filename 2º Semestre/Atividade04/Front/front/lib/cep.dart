import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cep extends StatefulWidget {
  @override
  _CepState createState() => _CepState();
}

class _CepState extends State<Cep> {
  final TextEditingController _cepController = TextEditingController();
  Map<String, dynamic>? _addressData;

  @override
  void initState() {
    super.initState();
    SetNullAddressData();
  }

  Future<void> _fetchAddress() async {
    final cep = _cepController.text.replaceAll(RegExp(r'\D'), '');
    final response =
        await http.get(Uri.parse('http://localhost:5095/cep/$cep'));

    if (response.statusCode == 200) {
      setState(() {
        _addressData = json.decode(response.body);
      });
    } else {
      setState(() {
        SetNullAddressData();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CEP não encontrado.')),
      );
    }
  }

  void _clearFields() {
    setState(() {
      _cepController.clear();
      SetNullAddressData();
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void SetNullAddressData() {
    _addressData = {
      'cep': '',
      'logradouro': '',
      'complemento': '',
      'bairro': '',
      'localidade': '',
      'uf': '',
      'estado': '',
      'ddd': '',
      'ibge': '',
      'gia': '',
      'siafi': '',
      'regiao': '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _cepController,
                  decoration: const InputDecoration(
                    labelText: 'Digite o CEP',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _fetchAddress,
                  child: const Text('Buscar'),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _clearFields,
                  child: const Text('Limpar'),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _logout,
                  child: const Text('Sair da Conta'),
                ),
                const SizedBox(height: 16.0),
                if (_addressData != null)
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _addressData!.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              '${entry.key}: ${entry.value}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
