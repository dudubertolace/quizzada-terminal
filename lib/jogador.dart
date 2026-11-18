class Jogador {
  final String nome;
  int pontos;

  Jogador({required this.nome, this.pontos = 0});

  void somaPontos(int valor) {
    pontos += valor;
  }
}
