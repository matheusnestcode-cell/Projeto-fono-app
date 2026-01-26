import 'package:intl/intl.dart';

class Relatorio {
  final String id; // UUID gerado localmente
  final String nomePaciente;
  final int idadePaciente;
  final String unidadeIdade; // "anos" ou "meses"
  final DateTime dataNascimento;
  final DateTime dataPreenchimento;
  final DateTime? dataProximaAvaliacao;
  final String statusAvaliacao; // "completo", "pendente", "revisão"
  
  final Triagem triagem;
  final List<Avaliacao> avaliacoes;
  final Diagnostico? diagnostico;

  Relatorio({
    required this.id,
    required this.nomePaciente,
    required this.idadePaciente,
    required this.unidadeIdade,
    required this.dataNascimento,
    required this.dataPreenchimento,
    this.dataProximaAvaliacao,
    required this.statusAvaliacao,
    required this.triagem,
    required this.avaliacoes,
    this.diagnostico,
  });

  // Converter para JSON (salvar localmente)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomePaciente': nomePaciente,
      'idadePaciente': idadePaciente,
      'unidadeIdade': unidadeIdade,
      'dataNascimento': dataNascimento.toIso8601String(),
      'dataPreenchimento': dataPreenchimento.toIso8601String(),
      'dataProximaAvaliacao': dataProximaAvaliacao?.toIso8601String(),
      'statusAvaliacao': statusAvaliacao,
      'triagem': triagem.toJson(),
      'avaliacoes': avaliacoes.map((a) => a.toJson()).toList(),
      'diagnostico': diagnostico?.toJson(),
    };
  }

  // Converter de JSON
  factory Relatorio.fromJson(Map<String, dynamic> json) {
    return Relatorio(
      id: json['id'],
      nomePaciente: json['nomePaciente'],
      idadePaciente: json['idadePaciente'],
      unidadeIdade: json['unidadeIdade'],
      dataNascimento: DateTime.parse(json['dataNascimento']),
      dataPreenchimento: DateTime.parse(json['dataPreenchimento']),
      dataProximaAvaliacao: json['dataProximaAvaliacao'] != null 
          ? DateTime.parse(json['dataProximaAvaliacao']) 
          : null,
      statusAvaliacao: json['statusAvaliacao'],
      triagem: Triagem.fromJson(json['triagem']),
      avaliacoes: List<Avaliacao>.from(
        json['avaliacoes'].map((a) => Avaliacao.fromJson(a))
      ),
      diagnostico: json['diagnostico'] != null 
          ? Diagnostico.fromJson(json['diagnostico']) 
          : null,
    );
  }
}

class Triagem {
  final String queixaPrincipal;
  final String duracaoQueixa;
  final String historicoPaciente;
  final String medicacoes;
  final String comorbidades;
  final String historicoFamiliar;
  final String ambienteFamily;
  final String escolaridade;

  Triagem({
    required this.queixaPrincipal,
    required this.duracaoQueixa,
    required this.historicoPaciente,
    required this.medicacoes,
    required this.comorbidades,
    required this.historicoFamiliar,
    required this.ambienteFamily,
    required this.escolaridade,
  });

  Map<String, dynamic> toJson() {
    return {
      'queixaPrincipal': queixaPrincipal,
      'duracaoQueixa': duracaoQueixa,
      'historicoPaciente': historicoPaciente,
      'medicacoes': medicacoes,
      'comorbidades': comorbidades,
      'historicoFamiliar': historicoFamiliar,
      'ambienteFamily': ambienteFamily,
      'escolaridade': escolaridade,
    };
  }

  factory Triagem.fromJson(Map<String, dynamic> json) {
    return Triagem(
      queixaPrincipal: json['queixaPrincipal'] ?? '',
      duracaoQueixa: json['duracaoQueixa'] ?? '',
      historicoPaciente: json['historicoPaciente'] ?? '',
      medicacoes: json['medicacoes'] ?? '',
      comorbidades: json['comorbidades'] ?? '',
      historicoFamiliar: json['historicoFamiliar'] ?? '',
      ambienteFamily: json['ambienteFamily'] ?? '',
      escolaridade: json['escolaridade'] ?? '',
    );
  }
}

class Avaliacao {
  final String id;
  final String nomeAvaliacao;
  final DateTime dataAvaliacao;
  final double? pontuacao;
  final Map<String, dynamic> resultado;
  final String observacoes;
  final bool statusConclusao;

  Avaliacao({
    required this.id,
    required this.nomeAvaliacao,
    required this.dataAvaliacao,
    this.pontuacao,
    required this.resultado,
    required this.observacoes,
    required this.statusConclusao,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomeAvaliacao': nomeAvaliacao,
      'dataAvaliacao': dataAvaliacao.toIso8601String(),
      'pontuacao': pontuacao,
      'resultado': resultado,
      'observacoes': observacoes,
      'statusConclusao': statusConclusao,
    };
  }

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      id: json['id'],
      nomeAvaliacao: json['nomeAvaliacao'],
      dataAvaliacao: DateTime.parse(json['dataAvaliacao']),
      pontuacao: json['pontuacao'],
      resultado: json['resultado'] ?? {},
      observacoes: json['observacoes'] ?? '',
      statusConclusao: json['statusConclusao'] ?? false,
    );
  }
}

class Diagnostico {
  final String diagnostico;
  final String cid10;
  final String condutaTerapeutica;
  final String frequenciaeSessoes;
  final DateTime dataConclusao;

  Diagnostico({
    required this.diagnostico,
    required this.cid10,
    required this.condutaTerapeutica,
    required this.frequenciaeSessoes,
    required this.dataConclusao,
  });

  Map<String, dynamic> toJson() {
    return {
      'diagnostico': diagnostico,
      'cid10': cid10,
      'condutaTerapeutica': condutaTerapeutica,
      'frequenciaeSessoes': frequenciaeSessoes,
      'dataConclusao': dataConclusao.toIso8601String(),
    };
  }

  factory Diagnostico.fromJson(Map<String, dynamic> json) {
    return Diagnostico(
      diagnostico: json['diagnostico'] ?? '',
      cid10: json['cid10'] ?? '',
      condutaTerapeutica: json['condutaTerapeutica'] ?? '',
      frequenciaeSessoes: json['frequenciaeSessoes'] ?? '',
      dataConclusao: DateTime.parse(json['dataConclusao']),
    );
  }
}
