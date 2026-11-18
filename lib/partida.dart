import 'dart:io';
import 'jogador.dart';
import 'pergunta.dart';
import 'dados_perguntas.dart';
import 'resposta_invalida.dart';

class Partida {
  final Jogador jogador;
  final List<Pergunta> perguntas;

  Partida({required this.jogador, required this.perguntas});

  factory Partida.criar({required Jogador jogador}) {
    final perguntas = dadosPerguntas.map((map) => Pergunta.fromMap(map)).toList();

    return Partida(jogador: jogador, perguntas: perguntas);
  }

  int get totalPontos => perguntas.fold(0, (total, pergunta) => total + pergunta.dificuldade.pontos);

  void iniciar() {
    print('QUIZ DE FUTEBOL');
    print('Bem vindo, ${jogador.nome}!\n');

    for (var i = 0; i < perguntas.length; i++) {
      final pergunta = perguntas[i];

      print('Pergunta ${i + 1}: ${pergunta.texto}\n');

      for (var j = 0; j < pergunta.alternativas.length; j++) {
        print('${j + 1}) ${pergunta.alternativas[j]}');
      }

      print('Digite o número da alternativa correta: ');

      try {
        final entrada = stdin.readLineSync();

        if (entrada == null || entrada.trim().isEmpty) {
          throw RespostaInvalidaException('Digite uma resposta!');
        }

        final resposta = int.parse(entrada);

        if (resposta < 1 || resposta > pergunta.alternativas.length) {
          throw RespostaInvalidaException('Escolha uma alternativa válida!');
        }

        if (resposta - 1 == pergunta.indiceCerto) {
          print('\nResposta correta!');
          jogador.somaPontos(pergunta.dificuldade.pontos);
        } else {
          print('\nResposta incorreta!');
        }
      } on FormatException {
        print('\nDigite apenas números!');
        i--;
      } on RespostaInvalidaException catch (erro) {
        print('$erro');
        i--;
      }
    }

    print('RESULTADO FINAL');
    print('Jogador: ${jogador.nome}');
    print('Pontuação: ${jogador.pontos}');
    print('Pontuação máxima: $totalPontos');
  }
}
