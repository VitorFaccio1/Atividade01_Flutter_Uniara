import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Jogo da Forca',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              child: const Text('Jogar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> palavras = [
    'FLUTTER',
    'DESENVOLVIMENTO',
    'PROGRAMACAO',
    'JAVASCRIPT',
    'PYTHON',
    'DESENVOLVEDOR',
    'COMPILADOR',
    'ALGORITMO',
    'INTERFACE',
    'BIBLIOTECA',
    'PLATAFORMA',
    'DESEMPENHO',
    'SEGURANCA',
    'APLICATIVO',
    'ESTRUTURA',
    'DESENVOLVIMENTO',
    'CODIFICACAO',
    'APRENDIZAGEM',
    'INTELIGENCIA',
    'ARMAZENAMENTO'
  ];
  String palavraSelecionada = '';
  String palavraExibida = '';
  int tentativas = 10;
  List<String> letrasEscolhidas = [];

  @override
  void initState() {
    super.initState();
    _selecionarPalavra();
  }

  void _selecionarPalavra() {
    final random = Random();
    palavraSelecionada = palavras[random.nextInt(palavras.length)];
    palavraExibida = '*' * palavraSelecionada.length;
  }

  void verificarLetra(String letra) {
    setState(() {
      if (!palavraSelecionada.contains(letra)) {
        tentativas--;
      }
      letrasEscolhidas.add(letra);
      _atualizarPalavraExibida();
      _verificarFimDoJogo();
    });
  }

  void _atualizarPalavraExibida() {
    palavraExibida = '';
    for (int i = 0; i < palavraSelecionada.length; i++) {
      if (letrasEscolhidas.contains(palavraSelecionada[i])) {
        palavraExibida += palavraSelecionada[i];
      } else {
        palavraExibida += '*';
      }
    }
  }

  void _verificarFimDoJogo() {
    if (tentativas == 0) {
      _mostrarAlerta('Você perdeu! A palavra era: $palavraSelecionada');
    } else if (!palavraExibida.contains('*')) {
      _mostrarAlerta('Parabéns! Você ganhou!');
    }
  }

  void _mostrarAlerta(String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fim do jogo'),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Forca'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Palavra: $palavraExibida',
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text('Tentativas restantes: $tentativas',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: MediaQuery.of(context).size.width ~/
                    80, // Define quantos botões por linha baseado no tamanho da tela
                children: List.generate(26, (index) {
                  final letra = String.fromCharCode(index + 65);
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: letrasEscolhidas.contains(letra)
                          ? null
                          : () => verificarLetra(letra),
                      child: Text(letra),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
