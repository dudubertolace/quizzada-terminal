import 'jogador.dart';
import 'pergunta.dart';
import 'dados_perguntas.dart';

class Partida {
  final Jogador jogador;
  final List<Pergunta> perguntas;

  Partida({required this.jogador, required this.perguntas});

  factory Partida.criar({required Jogador jogador}) {
    final perguntas = dadosPerguntas
        .map((map) => Pergunta.fromMap(map))
        .toList();

    return Partida(jogador: jogador, perguntas: perguntas);
  }

  int get totalPontos => perguntas.fold(
    0,
    (total, pergunta) => total + pergunta.dificuldade.pontos,
  );
}
