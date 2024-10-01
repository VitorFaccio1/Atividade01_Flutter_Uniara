import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/store.dart';
import 'register.dart'; // Make sure to import your register page

class ListStorePage extends StatefulWidget {
  @override
  _ListStorePageState createState() => _ListStorePageState();
}

class _ListStorePageState extends State<ListStorePage> {
  late Future<List<Store>> _storeList;

  @override
  void initState() {
    super.initState();
    _storeList = fetchStores();
  }

  Future<List<Store>> fetchStores() async {
    final response = await http.get(Uri.parse('http://localhost:5095/Stores'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map<Store>((store) => Store.fromJson(store)).toList();
    } else {
      throw Exception('Failed to load stores');
    }
  }

  void _logout() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Lojas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Deslogar',
            onPressed: _logout,
          ),
        ],
      ),
      body: FutureBuilder<List<Store>>(
        future: _storeList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar lojas: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma loja encontrada.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Store store = snapshot.data![index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    title: Text(store.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tipo: ${store.type}'),
                        Text('CEP: ${store.cep}'),
                        Text(
                            'Endereço: ${store.logradouro}, ${store.bairro}, ${store.localidade}, ${store.uf}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterStore()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Registrar Loja',
      ),
    );
  }
}
