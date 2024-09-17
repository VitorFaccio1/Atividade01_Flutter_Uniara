import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Consulta extends StatefulWidget {
  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  List<dynamic> equipamentos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEquipamentos();
  }

  Future<void> fetchEquipamentos() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8080/equipamentos'));

      if (response.statusCode == 200) {
        setState(() {
          equipamentos = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar equipamentos');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  // Função para reservar o equipamento
  Future<void> reservarEquipamento(int equipamentoId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/equipamentos/$equipamentoId/reservar'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // Atualize a lista de equipamentos após a reserva
        await fetchEquipamentos();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Equipamento reservado com sucesso!'),
        ));
      } else {
        final errorMessage = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao reservar equipamento'),
      ));
    }
  }

  // Função para liberar o equipamento reservado
  Future<void> liberarEquipamento(int equipamentoId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/equipamentos/$equipamentoId/liberar'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // Atualize a lista de equipamentos após a liberação
        await fetchEquipamentos();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Reserva liberada com sucesso!'),
        ));
      } else {
        final errorMessage = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao liberar reserva'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Equipamentos')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: equipamentos.length,
              itemBuilder: (context, index) {
                final equipamento = equipamentos[index];
                final dataRetirada = equipamento['dataRetirada'];
                return ListTile(
                  title: Text(equipamento['nome']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(equipamento['disponivel']
                          ? 'Disponível'
                          : 'Reservado'),
                      if (dataRetirada != null && dataRetirada.isNotEmpty)
                        Text('Data de Retirada: ${dataRetirada}'),
                    ],
                  ),
                  trailing: equipamento['disponivel']
                      ? ElevatedButton(
                          onPressed: () {
                            reservarEquipamento(equipamento['id']);
                          },
                          child: Text('Reservar'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            liberarEquipamento(equipamento['id']);
                          },
                          child: Text('Liberar'),
                        ),
                );
              },
            ),
    );
  }
}
