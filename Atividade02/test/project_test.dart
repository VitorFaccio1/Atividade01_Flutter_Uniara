import 'package:project/project.dart';
import 'package:test/test.dart';

void main() {
  test('Soma', () {
    expect(soma(3, 5), 8.0);
  });

  test('Verificar numero par', () {
    expect(verificaNumeroPar(3), false);
    expect(verificaNumeroPar(2), true);
  });

  test('Verificar numero positivo', () {
    expect(verificaNumeroPositivo(-3), false);
    expect(verificaNumeroPositivo(2), true);
    expect(verificaNumeroPositivo(0), true);
  });

  test('Mostra sucessor', () {
    expect(sucessorNumero(3), 4);
    expect(sucessorNumero(-3), -2);
  });

  test('Mostra antecessor', () {
    expect(antecessorNumero(3), 2);
    expect(antecessorNumero(-3), -4);
  });

  test('Quantidade de salarios minimos', () {
    expect(quantidadeSalariosMinimo(1.412), 1);
    expect(quantidadeSalariosMinimo(2.824), 2);
  });

  test('Reajusta valor', () {
    expect(reajusteValor(100), 105);
  });

  test('Reajusta valor', () {
    expect(reajusteValor(100), 105);
  });

  test('Ordena lista ordem decrescente', () {
    var lista = [2, 3, 4];

    expect(lista, [2, 3, 4]);

    ordenaListaDecrescente(lista);

    expect(lista, [4, 3, 2]);
  });

  test('Calcula IMC', () {
    expect(calculaIMC(85, 1.80), 26.234567901234566);
  });

  test('Ordena lista ordem decrescente', () {
    List<double> lista = [9, 8, 6];

    expect(mediaNotas(lista), 7.666666666666667);
  });
}
