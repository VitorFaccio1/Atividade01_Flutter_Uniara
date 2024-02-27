import 'package:initial/initial.dart';
import 'package:test/test.dart';

void main() {
  test('Soma Numeros Pares', () {
    expect(SomaNumerosPares(5), 6);
  });

  test('Fatorial', () {
    expect(Fatorial(5), 120);
  });

  test('Verificar Numero Primo', () {
    expect(VerificarNumeroPrimo(5), true);
    expect(VerificarNumeroPrimo(6), false);
  });

  test('Verificar Palindromo', () {
    expect(VerificarPalindromo("kaiak"), true);
    expect(VerificarPalindromo("Vitor"), false);
  });

  test('Converter Celsius Para Fahrenheit', () {
    expect(ConverterCelsiusParaFahrenheit(32), 89.6);
  });

  test('Calcular IMC', () {
    expect(CalculaIMC(85, 180), 26.234567901234566);
  });

  test('Multiplicar', () {
    expect(Multiplicar(3, 5), 15);
  });
}
