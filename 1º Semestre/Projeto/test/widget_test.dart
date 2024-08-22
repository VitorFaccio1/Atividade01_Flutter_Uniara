import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto/main.dart';

void main() {
  testWidgets('Verifica a selecao de uma palavra', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GameScreen()));

    var state = tester.state<GameScreenState>(find.byType(GameScreen));
    expect(state.palavraSelecionada.isNotEmpty, true);
    expect(state.palavraExibida.length, state.palavraSelecionada.length);
  });

  testWidgets('Verifica a atualizacao da palavra exibida',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GameScreen()));

    var state = tester.state<GameScreenState>(find.byType(GameScreen));
    state.palavraSelecionada = 'FLUTTER';
    state.palavraExibida = '*******';
    state.letrasEscolhidas = ['F', 'L'];

    state.atualizarPalavraExibida();
    expect(state.palavraExibida, 'FL*****');
  });

  testWidgets('Verifica o fim do jogo ao ganhar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GameScreen()));

    var state = tester.state<GameScreenState>(find.byType(GameScreen));
    state.palavraSelecionada = 'FLUTTER';
    state.palavraExibida = 'FLUTTER';
    state.tentativas = 10;

    state.verificarFimDoJogo();
    await tester.pump();

    expect(find.text('Parabens! Voce ganhou!'), findsOneWidget);
  });

  testWidgets('Verifica o fim do jogo ao perder', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GameScreen()));

    var state = tester.state<GameScreenState>(find.byType(GameScreen));
    state.palavraSelecionada = 'FLUTTER';
    state.palavraExibida = '*******';
    state.tentativas = 0;

    state.verificarFimDoJogo();
    await tester.pump();

    expect(find.text('Voce perdeu! A palavra era: FLUTTER'), findsOneWidget);
  });

  testWidgets('Verifica a interacao com os botoes de letras',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GameScreen()));

    var state = tester.state<GameScreenState>(find.byType(GameScreen));
    state.palavraSelecionada = 'FLUTTER';
    state.palavraExibida = '*******';
    state.tentativas = 10;

    await tester.tap(find.text('F'));
    await tester.pump();

    expect(state.letrasEscolhidas.contains('F'), true);
    expect(state.tentativas, 10);
    expect(state.palavraExibida, 'F******');
  });

  testWidgets('Verifica reducao de tentativas ao escolher letra errada',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GameScreen()));

    var state = tester.state<GameScreenState>(find.byType(GameScreen));
    state.palavraSelecionada = 'FLUTTER';
    state.palavraExibida = '*******';
    state.tentativas = 10;

    await tester.tap(find.text('Z'));
    await tester.pump();

    expect(state.letrasEscolhidas.contains('Z'), true);
    expect(state.tentativas, 9);
  });
}
