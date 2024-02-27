import 'dart:math';

int SomaNumerosPares(int numeroLimite) {
  var soma = 0;

  for (int i = 1; i <= numeroLimite; i++) {
    if (i % 2 == 0) soma += i;
  }

  return soma;
}

int Fatorial(int numero) {
  var fatorial = 1;

  for (int i = numero; i > 0; i--) fatorial *= i;

  return fatorial;
}

bool VerificarNumeroPrimo(int numero) {
  if (numero <= 1) return false;

  if (numero == 2) return true;

  for (int i = 2; i <= sqrt(numero); i++) {
    if (numero % i == 0) return false;
  }

  return true;
}

bool VerificarPalindromo(String palavra) {
  for (int i = 0; i <= palavra.length / 2; i++) {
    if (palavra[i] != palavra[palavra.length - 1 - i]) return false;
  }

  return true;
}

double ConverterCelsiusParaFahrenheit(double graus) {
  return (graus * (9 / 5)) + 32;
}

double CalculaIMC(double peso, int altura) {
  var alturaMetros = altura / 100;

  return (peso / (alturaMetros * alturaMetros));
}

double Multiplicar(double valor, int fator) {
  return valor * fator;
}
