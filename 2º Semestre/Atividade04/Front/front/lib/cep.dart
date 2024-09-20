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
    final cep = _cepController.text
        .replaceAll(RegExp(r'\D'), ''); // Remove caracteres não numéricos
    final response = await http.get(Uri.parse(
        'http://localhost:5095/cep/$cep')); // Substitua pela URL correta

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                onPressed: _logout, child: const Text('Sair da Conta')),
            const SizedBox(height: 16.0),
            if (_addressData != null) ...[
              Text('CEP: ${_addressData!['cep']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Logradouro: ${_addressData!['logradouro']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Complemento: ${_addressData!['complemento']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Bairro: ${_addressData!['bairro']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Cidade: ${_addressData!['localidade']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('UF: ${_addressData!['uf']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Estado: ${_addressData!['estado']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('DDD: ${_addressData!['ddd']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('IBGE: ${_addressData!['ibge']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('GIA: ${_addressData!['gia']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('SIAFI: ${_addressData!['siafi']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Região: ${_addressData!['regiao']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ],
        ),
      ),
    );
  }
}
