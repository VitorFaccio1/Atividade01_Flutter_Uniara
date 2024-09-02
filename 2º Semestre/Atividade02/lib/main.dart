import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo de Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<String> _tarefas = [];
  final TextEditingController _taskController = TextEditingController();
  int? _editIndex;

  void _adicionarTarefa() {
    final tarefa = _taskController.text.trim();
    if (tarefa.isNotEmpty) {
      setState(() {
        if (_editIndex != null) {
          _tarefas[_editIndex!] = tarefa;
          _editIndex = null;
        } else {
          _tarefas.add(tarefa);
        }
      });
      _taskController.clear();
    }
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  void _editarTarefa(int index) {
    setState(() {
      _taskController.text = _tarefas[index];
      _editIndex = index;
    });
  }

  void _marcarComoConcluida(int index) {
    setState(() {
      if (_tarefas[index].startsWith('✓ ')) {
        _tarefas[index] = _tarefas[index].substring(2);
      } else {
        _tarefas[index] = '✓ ${_tarefas[index]}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: _editIndex == null ? 'Adicionar nova tarefa' : 'Editar tarefa',
                suffixIcon: IconButton(
                  icon: Icon(Icons.save),
                  onPressed: _adicionarTarefa,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _tarefas[index],
                      style: TextStyle(
                        decoration: _tarefas[index].startsWith('✓ ') ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removerTarefa(index),
                    ),
                    onTap: () => _editarTarefa(index),
                    onLongPress: () => _marcarComoConcluida(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}