import 'dart:io';

import 'package:initial/initial.dart' as initial;

void main(List<String> arguments) {
  bool continueMenu = true;

  while (continueMenu) {
    print('\n\n\n\n\n');

    Menu();

    stdout.write('Deseja continuar? sim(1) ou não(2) ');
    int opcao = int.parse(stdin.readLineSync()!);

    continueMenu = opcao == 1;
  }
}

void Menu() {
  print("Digite o que deseja fazer: \n1)Somar Numeros Pares\n2)Fazer fatorial" +
      "\n3)Verificar numeros primo\n4)Palindromo\n5)Conversão de temperatura" +
      "\n6)Calculadora de IMC\n7)Tabuada");
  int opcao = int.parse(stdin.readLineSync()!);

  switch (opcao) {
    case 1:
      print("Digite até qual numero você deseja realizar a soma: ");
      int numeroLimite = int.parse(stdin.readLineSync()!);

      print(
          'Soma dos Números Pares: ${initial.SomaNumerosPares(numeroLimite)}');

      break;

    case 2:
      print("Digite até qual numero você deseja realizar o fatorial: ");
      int fatorial = int.parse(stdin.readLineSync()!);

      print('Fatorial de ${fatorial}: ${initial.Fatorial(fatorial)}');

      break;

    case 3:
      print("Digite um numero: ");
      int numero = int.parse(stdin.readLineSync()!);

      print(
          '${numero} é primo? Resposta: ${initial.VerificarNumeroPrimo(numero)}');

      break;

    case 4:
      print("Digite uma palavra: ");
      String palavra = stdin.readLineSync()!;

      print('É palindromo: ${initial.VerificarPalindromo(palavra)}');

      break;

    case 5:
      print("Digite uma valor em Celsius para converter para Fahrenheit: ");
      double celsius = double.parse(stdin.readLineSync()!);

      print(
          'A temperatura em Celsius: ${celsius} é igual ${initial.ConverterCelsiusParaFahrenheit(celsius)} Fahrenheit');

      break;

    case 6:
      print("Calcule seu IMC\nDigite seu peso: ");
      double peso = double.parse(stdin.readLineSync()!);

      print("\nDigite sua altura em cm: ");
      int altura = int.parse(stdin.readLineSync()!);

      print('Seu IMC: ${initial.CalculaIMC(peso, altura)}');

      break;

    case 7:
      print("Digite uma valor para criar a tabuada: ");
      double valor = double.parse(stdin.readLineSync()!);

      for (int i = 0; i <= 10; i++) {
        print("${valor} x ${i} = ${initial.Multiplicar(valor, i)}\n");
      }

      break;
  }
}
