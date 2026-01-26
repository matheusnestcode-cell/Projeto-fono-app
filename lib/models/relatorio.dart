import 'package:cloud_firestore/cloud_firestore.dart';

class Relatorio {
  final String? id;
  final String nomePaciente;
  final int idadePaciente;
  final String unidadeIdade; // 'anos' ou 'meses'
  final DateTime dataNascimento;
  final DateTime dataPreenchimento;
  final String nomeAvaliador;
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
  final int totalHabilidades;
  final int totalCognitivo;
  final int totalGeral;
  final String userUid; // UID do usuário que criou o relatório
  final DateTime criadoEm;
  final DateTime? atualizadoEm;

  Relatorio({
    this.id,
    required this.nomePaciente,
    required this.idadePaciente,
    required this.unidadeIdade,
    required this.dataNascimento,
    required this.dataPreenchimento,
    required this.nomeAvaliador,
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
    required this.totalHabilidades,
    required this.totalCognitivo,
    required this.totalGeral,
    required this.userUid,
    DateTime? criadoEm,
    this.atualizadoEm,
  }) : criadoEm = criadoEm ?? DateTime.now();

  // Converter para JSON para enviar ao Firestore
  Map<String, dynamic> toJson() {
    return {
      'nomePaciente': nomePaciente,
      'idadePaciente': idadePaciente,
      'unidadeIdade': unidadeIdade,
      'dataNascimento': Timestamp.fromDate(dataNascimento),
      'dataPreenchimento': Timestamp.fromDate(dataPreenchimento),
      'nomeAvaliador': nomeAvaliador,
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
      'totalHabilidades': totalHabilidades,
      'totalCognitivo': totalCognitivo,
      'totalGeral': totalGeral,
      'userUid': userUid,
      'criadoEm': Timestamp.fromDate(criadoEm),
      'atualizadoEm': atualizadoEm != null ? Timestamp.fromDate(atualizadoEm!) : null,
    };
  }

  // Criar Relatório a partir do Firestore
  factory Relatorio.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Relatorio(
      id: doc.id,
      nomePaciente: data['nomePaciente'] ?? '',
      idadePaciente: data['idadePaciente'] ?? 0,
      unidadeIdade: data['unidadeIdade'] ?? 'anos',
      dataNascimento: (data['dataNascimento'] as Timestamp).toDate(),
      dataPreenchimento: (data['dataPreenchimento'] as Timestamp).toDate(),
      nomeAvaliador: data['nomeAvaliador'] ?? '',
      dialogo: Map<String, int>.from(data['dialogo'] ?? {}),
      funcoes: Map<String, int>.from(data['funcoes'] ?? {}),
      meiosComunicacao: data['meiosComunicacao'] ?? 0,
      nivelContextualizacao: data['nivelContextualizacao'] ?? 0,
      compreensaoVerbal: data['compreensaoVerbal'] ?? 0,
      manipulacao: Map<String, int>.from(data['manipulacao'] ?? {}),
      desenvolvimentoSimbolismo: data['desenvolvimentoSimbolismo'] ?? 0,
      organizacaoBrinquedo: data['organizacaoBrinquedo'] ?? 0,
      observacoes: data['observacoes'] ?? '',
      conclusoes: data['conclusoes'] ?? '',
      totalHabilidades: data['totalHabilidades'] ?? 0,
      totalCognitivo: data['totalCognitivo'] ?? 0,
      totalGeral: data['totalGeral'] ?? 0,
      userUid: data['userUid'] ?? '',
      criadoEm: (data['criadoEm'] as Timestamp).toDate(),
      atualizadoEm: data['atualizadoEm'] != null 
          ? (data['atualizadoEm'] as Timestamp).toDate() 
          : null,
    );
  }
}
