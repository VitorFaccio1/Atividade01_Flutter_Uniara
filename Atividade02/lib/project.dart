double soma(double a, double b) {
  return a + b;
}

bool verificaNumeroPositivo(double numero) {
  return numero >= 0;
}

bool verificaNumeroPar(double numero) {
  return numero % 2 == 0;
}

double sucessorNumero(double numero) {
  return numero + 1;
}

double antecessorNumero(double numero) {
  return numero - 1;
}

double quantidadeSalariosMinimo(double salarioUsuario) {
  //R$1.412 salario minimo no dia 03/03/2024
  return salarioUsuario / 1.412;
}

double reajusteValor(double valor) {
  //valor reajustado em 5%
  return valor + (valor * 0.05);
}

void ordenaListaDecrescente(List<int> valores) {
  valores.sort((a, b) => b.compareTo(a));
}

double calculaIMC(double peso, double altura) {
  return peso / (altura * altura);
}

double mediaNotas(List<double> notas) {
  double soma = 0;

  for (var nota in notas) {
    soma += nota;
  }

  return soma / notas.length;
}
