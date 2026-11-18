import 'dificuldade.dart';

class Pergunta {
  final String texto;
  final List<String> alternativas;
  final int indiceCerto;
  final Dificuldade dificuldade;

  Pergunta ({required this.texto, required this.alternativas, required this.indiceCerto, required this.dificuldade});

  factory Pergunta.fromMap(Map<String, dynamic> map) {
    return Pergunta( 
      texto: map['texto'] as String,
      alternativas: List<String>.from(map['alternativas']),
      indiceCerto: map['indiceCerto'] as int,
      dificuldade: Dificuldade.values.byName( 
        map['dificuldade'] as String,
      ),
    );
  }
}