import 'dart:io'; // le o que o jogador digita
import 'dart:math'; // faz parte do meu bonus escolhido, vai embaralhar as alternativas

import 'jogador.dart';
import 'pergunta.dart';
import 'dados_perguntas.dart';
import 'dificuldade.dart';
import 'resposta_invalida.dart';

class Partida {
  final Jogador jogador;
  final List<Pergunta> perguntas;
  int acertos = 0;

  Partida({required this.jogador, required this.perguntas});

  factory Partida.criar({required Jogador jogador, required String filtro}) {
    final perguntasConvertidas = dadosPerguntas
        .map((map) => Pergunta.fromMap(map))
        .toList();

    final perguntasFiltradas = perguntasConvertidas.where((pergunta) {
      if (filtro == '1') {
        return pergunta.dificuldade == Dificuldade.facil;
      }

      if (filtro == '2') {
        return pergunta.dificuldade == Dificuldade.dificil;
      }

      return true;
    }).toList();

    final random = Random();

    final perguntasEmbaralhadas = perguntasFiltradas.map((pergunta) {
      final alternativas = List<String>.from(pergunta.alternativas);

      final respostaCorreta = alternativas[pergunta.indiceCerto];

      alternativas.shuffle(random);

      return Pergunta(
        texto: pergunta.texto,
        alternativas: alternativas,
        indiceCerto: alternativas.indexOf(respostaCorreta),
        dificuldade: pergunta.dificuldade,
      );
    }).toList();

    return Partida(jogador: jogador, perguntas: perguntasEmbaralhadas);
  }

  int get totalPontos => perguntas.fold(
    0,
    (total, pergunta) => total + pergunta.dificuldade.pontos,
  );

  void iniciar() {
    print('QUIZ DE FUTEBOL');
    print('Bem vindo, ${jogador.nome}!\n');

    for (var i = 0; i < perguntas.length; i++) {
      final pergunta = perguntas[i];

      print('Pergunta ${i + 1}/${perguntas.length}: ${pergunta.texto}\n');

      for (var j = 0; j < pergunta.alternativas.length; j++) {
        print('${j + 1}) ${pergunta.alternativas[j]}');
      }

      var respostaValida = false;

      while (!respostaValida) {
        print('\nDigite o número da alternativa correta:');

        try {
          final entrada = stdin.readLineSync();

          if (entrada == null || entrada.trim().isEmpty) {
            throw RespostaInvalidaException('Digite uma resposta!');
          }

          final resposta = int.parse(entrada.trim());

          if (resposta < 1 || resposta > pergunta.alternativas.length) {
            throw RespostaInvalidaException('Escolha uma alternativa válida!');
          }

          if (resposta - 1 == pergunta.indiceCerto) {
            print('\nResposta correta!');
            jogador.somaPontos(pergunta.dificuldade.pontos);
            acertos++;
          } else {
            print('\nResposta incorreta!');
          }
          print(
            'Resposta certa: ${pergunta.indiceCerto + 1}) '
            '${pergunta.alternativas[pergunta.indiceCerto]}',
          );

          respostaValida = true;
        } on FormatException {
          print('\nDigite apenas números!');
        } on RespostaInvalidaException catch (erro) {
          print('\n$erro');
        }
      }
    }

    print('===== RESULTADO FINAL =====');
    print('Jogador: ${jogador.nome}');
    print('Pontuação: ${jogador.pontos}');
    print('Pontuação máxima: $totalPontos');
    print('Acertos: $acertos de ${perguntas.length}');
  }
}
