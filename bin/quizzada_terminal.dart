import 'dart:io';

import 'package:quizzada_terminal/jogador.dart';
import 'package:quizzada_terminal/partida.dart';

void main() {
  print('QUIZ DE FUTEBOL');
  print('Digite seu nome:');

  final nome = stdin.readLineSync();

  if (nome == null || nome.trim().isEmpty) {
    print('Nome inválido!');
    return;
  }

  final jogador = Jogador(nome: nome.trim());

  final partida = Partida.criar(jogador: jogador);

  partida.iniciar();
}
