import 'paciente.dart';

class Avaliacao {
  final Paciente paciente;
  final DateTime data;
  final Map<String, int> dialogo;
  final Map<String, int> funcoes;
  final int meiosComunicacao;
  final int nivelContextualizacao;
  final int compreensaoVerbal;
  final Map<String, int> manipulacao;
  final int desenvolvimentoSimbolismo;
  final int organizacaoBrinquedo;
  final String observacoes;
  final String conclusoes;

  Avaliacao({
    required this.paciente,
    required this.data,
    required this.dialogo,
    required this.funcoes,
    required this.meiosComunicacao,
    required this.nivelContextualizacao,
    required this.compreensaoVerbal,
    required this.manipulacao,
    required this.desenvolvimentoSimbolismo,
    required this.organizacaoBrinquedo,
    required this.observacoes,
    required this.conclusoes,
  });

  int get totalHabilidades {
    final totalDialogo = dialogo.values.fold(0, (sum, value) => sum + value);
    final totalFuncoes = funcoes.values.fold(0, (sum, value) => sum + value);
    return totalDialogo + totalFuncoes + meiosComunicacao + nivelContextualizacao;
  }

  int get totalCognitivo {
    final totalManipulacao = manipulacao.values.fold(0, (sum, value) => sum + value);
    return totalManipulacao + desenvolvimentoSimbolismo + organizacaoBrinquedo;
  }

  int get totalGeral {
    return totalHabilidades + compreensaoVerbal + totalCognitivo;
  }
}