class Store {
  final String name;
  final String type;
  final String cep;
  final String logradouro;
  final String bairro;
  final String localidade;
  final String uf;

  Store({
    required this.name,
    required this.type,
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      name: json['name'],
      type: json['type'],
      cep: json['cep'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
    );
  }
}
