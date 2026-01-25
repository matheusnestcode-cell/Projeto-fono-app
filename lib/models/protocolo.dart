class ProtocoloCompleto {
  final int pacienteId;
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

  ProtocoloCompleto({
    required this.pacienteId,
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

  Map<String, dynamic> toJson() {
    return {
      'pacienteId': pacienteId,
      'dialogo': dialogo,
      'funcoes': funcoes,
      'meiosComunicacao': meiosComunicacao,
      'nivelContextualizacao': nivelContextualizacao,
      'compreensaoVerbal': compreensaoVerbal,
      'manipulacao': manipulacao,
      'desenvolvimentoSimbolismo': desenvolvimentoSimbolismo,
      'organizacaoBrinquedo': organizacaoBrinquedo,
      'observacoes': observacoes,
      'conclusoes': conclusoes,
      'totalHabilidades': _calcularTotalHabilidades(),
      'totalCompreensao': compreensaoVerbal,
      'totalCognitivo': _calcularTotalCognitivo(),
      'totalGeral': _calcularTotalGeral(),
    };
  }

  int _calcularTotalHabilidades() {
    final totalDialogo = dialogo.values.fold(0, (sum, value) => sum + value);
    final totalFuncoes = funcoes.values.fold(0, (sum, value) => sum + value);
    return totalDialogo + totalFuncoes + meiosComunicacao + nivelContextualizacao;
  }

  int _calcularTotalCognitivo() {
    final totalManipulacao = manipulacao.values.fold(0, (sum, value) => sum + value);
    return totalManipulacao + desenvolvimentoSimbolismo + organizacaoBrinquedo;
  }

  int _calcularTotalGeral() {
    return _calcularTotalHabilidades() + compreensaoVerbal + _calcularTotalCognitivo();
  }

  factory ProtocoloCompleto.fromJson(Map<String, dynamic> json) {
    return ProtocoloCompleto(
      pacienteId: json['pacienteId'],
      dialogo: Map<String, int>.from(json['dialogo']),
      funcoes: Map<String, int>.from(json['funcoes']),
      meiosComunicacao: json['meiosComunicacao'],
      nivelContextualizacao: json['nivelContextualizacao'],
      compreensaoVerbal: json['compreensaoVerbal'],
      manipulacao: Map<String, int>.from(json['manipulacao']),
      desenvolvimentoSimbolismo: json['desenvolvimentoSimbolismo'],
      organizacaoBrinquedo: json['organizacaoBrinquedo'],
      observacoes: json['observacoes'],
      conclusoes: json['conclusoes'],
    );
  }
}