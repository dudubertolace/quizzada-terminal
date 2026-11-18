import 'dart:io';

import 'package:quizzada_terminal/jogador.dart'; // ao rodar dart analyze, foi apresentado erro e sugerido importar o arquivo usando 'package: ...'
import 'package:quizzada_terminal/partida.dart';

void main() {
  print('QUIZ DE FUTEBOL');

  String nome = '';

  while (nome.isEmpty) {
    print('\nDigite seu nome:');

    final entrada = stdin.readLineSync();
    nome = entrada?.trim() ?? '';

    if (nome.isEmpty) {
      print('Nome inválido! Digite novamente.');
    }
  }

  print('\nEscolha a dificuldade:');
  print('1 - Somente perguntas fáceis');
  print('2 - Somente perguntas difíceis');
  print('3 - Todas as perguntas');

  String filtro = '';

  while (filtro != '1' && filtro != '2' && filtro != '3') {
    print('\nSua escolha:');

    final entrada = stdin.readLineSync();
    filtro = entrada?.trim() ?? '';

    if (filtro != '1' && filtro != '2' && filtro != '3') {
      print('Opção inválida! Escolha 1, 2 ou 3.');
    }
  }

  final jogador = Jogador(nome: nome);

  final partida = Partida.criar(jogador: jogador, filtro: filtro);

  partida.iniciar();
}
