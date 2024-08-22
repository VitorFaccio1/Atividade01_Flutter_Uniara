import 'package:project/project.dart' as project;
import 'dart:io';

void main(List<String> arguments) {
  menu();
}

void menu() {
  bool sair = false;

  while (!sair) {
    print("\nMenu:");
    print("1. Soma de Valores");
    print("2. Verificação de Números Positivos e Pares");
    print("3. Mostrar Sucessor e Antecessor");
    print("4. Cálculo de Quantidade de Salários Mínimos");
    print("5. Cálculo de Reajuste de Valor");
    print("6. Verificação de Booleanos");
    print("7. Ordenação de Lista em Ordem Decrescente");
    print("8. Cálculo de IMC");
    print("9. Média de 3 Notas");
    print("10. Verificar Aluno Aprovado/Reprovado");
    print("0. Sair\n");

    stdout.write("Escolha uma opção: ");
    var opcao = int.parse(stdin.readLineSync().toString());

    switch (opcao) {
      case 1:
        somaValores();
        break;
      case 2:
        verificaNumerosPositivosEPares();
        break;
      case 3:
        mostraSucessorEAntecessor();
        break;
      case 4:
        calculaQuantidadeSalariosMinimo();
        break;
      case 5:
        calculaReajusteValor();
        break;
      case 6:
        verificarBooleanos();
        break;
      case 7:
        ordenaListaOrdemDecrescente();
        break;
      case 8:
        calculaImc();
        break;
      case 9:
        media3Notas();
        break;
      case 10:
        verificaAlunoAprovadoReprovado();
        break;
      case 0:
        sair = true;
        print("Saindo do programa...");
        break;
      default:
        print("Opção inválida. Por favor, escolha uma opção válida.");
    }
  }
}

void verificaAlunoAprovadoReprovado() {
  List<double> notas = [];

  print("Insira nota 1: ");
  notas.add(double.parse(stdin.readLineSync().toString()));

  print("Insira nota 2: ");
  notas.add(double.parse(stdin.readLineSync().toString()));

  print("Insira nota 3: ");
  notas.add(double.parse(stdin.readLineSync().toString()));

  print("Insira nota 4: ");
  notas.add(double.parse(stdin.readLineSync().toString()));

  var media = project.mediaNotas(notas);

  print(
      "Media das notas: $media\nO aluno foi: ${media >= 7 ? "Aprovado" : "Reprovado"}");
}

void media3Notas() {
  List<double> notas = [];

  print("Insira nota 1: ");
  notas.add(double.parse(stdin.readLineSync().toString()));

  print("Insira nota 2: ");
  notas.add(double.parse(stdin.readLineSync().toString()));

  print("Insira nota 3: ");
  notas.add(double.parse(stdin.readLineSync().toString()));

  print("Media das notas: ${project.mediaNotas(notas)}");
}

void calculaImc() {
  print("Insira o seu peso: ");
  var peso = double.parse(stdin.readLineSync().toString());

  print("Insira a sua altura em centimetros: ");
  var altura = int.parse(stdin.readLineSync().toString());

  var imc = project.calculaIMC(peso, altura / 100);

  print("IMC: $imc\n");

  if (imc < 18.5) {
    print("Abaixo do peso");
  } else if (imc >= 18.5 && imc <= 24.9) {
    print("Peso ideal (parabéns)");
  } else if (imc >= 25.0 && imc <= 29.9) {
    print("Levemente acima do peso");
  } else if (imc >= 30.0 && imc <= 34.9) {
    print("Obesidade grau I");
  } else if (imc >= 35.0 && imc <= 39.9) {
    print("Obesidade grau II (severa)");
  } else {
    print("Obesidade grau III (mórbida)");
  }
}

void ordenaListaOrdemDecrescente() {
  List<int> numeros = [];

  print("Insira o primeiro número: ");
  numeros.add(int.parse(stdin.readLineSync().toString()));

  print("Insira o segundo número: ");
  numeros.add(int.parse(stdin.readLineSync().toString()));

  print("Insira o terceiro número: ");
  numeros.add(int.parse(stdin.readLineSync().toString()));

  print("Números inseridos na lista: $numeros");

  project.ordenaListaDecrescente(numeros);

  print("lista ordenada em ordem decrescente é: $numeros");
}

void verificarBooleanos() {
  print("Insira true ou false: ");
  var valor = bool.parse(stdin.readLineSync().toString());

  print("Insira true ou false: ");
  var valor2 = bool.parse(stdin.readLineSync().toString());

  if (valor && valor2) {
    print("Ambos são VERDADEIROS");
  } else if (!valor && !valor2) {
    print("Ambos são FALSOS");
  } else {
    print("Um é VERDADEIRO e o outro é FALSO");
  }
}

void calculaReajusteValor() {
  print("Insira o valor a ser reajustado em 5%: ");
  var valor = double.parse(stdin.readLineSync().toString());

  print(
      "O valor de $valor reajustado em 5% é igual a: ${project.reajusteValor(valor)}");
}

void calculaQuantidadeSalariosMinimo() {
  print("Insira o seu salario: ");
  var salarioUsuario = double.parse(stdin.readLineSync().toString());

  print(
      "Seu salario equivale a ${project.quantidadeSalariosMinimo(salarioUsuario)} salarios minimos");
}

void mostraSucessorEAntecessor() {
  print("Insira um numero qualquer: ");
  var numero = double.parse(stdin.readLineSync().toString());

  print("Numero: $numero\nAntecessor: ${project.antecessorNumero(numero)}"
      "\nSucessor: ${project.sucessorNumero(numero)}");
}

void verificaNumerosPositivosEPares() {
  print("Insira um numero qualquer: ");
  var numero = double.parse(stdin.readLineSync().toString());

  print("O numero é ${project.verificaNumeroPar(numero) ? "par" : "ímpar"} "
      "e ${project.verificaNumeroPositivo(numero) ? "positivo" : "negativo"}");
}

void somaValores() {
  print("Insira o valor de A: ");
  var a = double.parse(stdin.readLineSync().toString());

  print("Insira o valor de B: ");
  var b = double.parse(stdin.readLineSync().toString());

  print("Insira o valor de C: ");
  var c = double.parse(stdin.readLineSync().toString());

  var soma = project.soma(a, b);

  print(
      "A soma de A + B = $soma, e a soma ${soma < c ? "não é" : "é"} maior que C");
}
