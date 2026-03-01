import '../models/protocolo.dart';

class CalculadoraService {
  static Map<String, dynamic> calcularResultados(ProtocoloCompleto protocolo) {
    // Calcular totais por seção
    final totalDialogo = protocolo.dialogo.values.fold(0, (sum, value) => sum + value);
    final totalFuncoes = protocolo.funcoes.values.fold(0, (sum, value) => sum + value);
    final totalHabilidades = totalDialogo + totalFuncoes + 
                           protocolo.meiosComunicacao + protocolo.nivelContextualizacao;
    
    final totalManipulacao = protocolo.manipulacao.values.fold(0, (sum, value) => sum + value);
    final totalCognitivo = totalManipulacao + 
                          protocolo.desenvolvimentoSimbolismo + 
                          protocolo.organizacaoBrinquedo;
    
    final totalGeral = totalHabilidades + protocolo.compreensaoVerbal + totalCognitivo;

    // Calcular percentuais
    final percentualHabilidades = (totalHabilidades / 60 * 100).toInt();
    final percentualCompreensao = (protocolo.compreensaoVerbal / 40 * 100).toInt();
    final percentualCognitivo = (totalCognitivo / 50 * 100).toInt();
    final percentualGeral = (totalGeral / 150 * 100).toInt();

    // Interpretar resultados
    final interpretacao = _interpretarResultado(totalGeral);
    final recomendacoes = _gerarRecomendacoes(protocolo, totalGeral);

    return {
      'totais': {
        'dialogo': totalDialogo,
        'funcoes': totalFuncoes,
        'habilidades': totalHabilidades,
        'compreensao': protocolo.compreensaoVerbal,
        'cognitivo': totalCognitivo,
        'geral': totalGeral,
      },
      'percentuais': {
        'habilidades': percentualHabilidades,
        'compreensao': percentualCompreensao,
        'cognitivo': percentualCognitivo,
        'geral': percentualGeral,
      },
      'interpretacao': interpretacao,
      'recomendacoes': recomendacoes,
      'pontuacaoMaxima': {
        'dialogo': 16,
        'funcoes': 14,
        'meios': 15,
        'contextualizacao': 15,
        'habilidades': 60,
        'compreensao': 40,
        'cognitivo': 50,
        'geral': 150,
      },
    };
  }

  static String _interpretarResultado(int totalGeral) {
    if (totalGeral >= 135) {
      return 'EXCELENTE DESENVOLVIMENTO';
    } else if (totalGeral >= 120) {
      return 'BOM DESENVOLVIMENTO';
    } else if (totalGeral >= 90) {
      return 'DESENVOLVIMENTO ADEQUADO';
    } else if (totalGeral >= 60) {
      return 'DESENVOLVIMENTO AQUÉM DO ESPERADO';
    } else {
      return 'NECESSITA DE INTERVENÇÃO ESPECIALIZADA';
    }
  }

  static List<String> _gerarRecomendacoes(ProtocoloCompleto protocolo, int totalGeral) {
    final recomendacoes = <String>[];

    // Analisar habilidades dialógicas
    if ((protocolo.dialogo['inicia'] ?? 0) < 2) {
      recomendacoes.add('Estimular a iniciativa na comunicação');
    }
    if ((protocolo.dialogo['aguarda_turno'] ?? 0) < 2) {
      recomendacoes.add('Trabalhar a espera de turno nas interações');
    }

    // Analisar funções comunicativas
    final funcoesFaltantes = protocolo.funcoes.entries
        .where((entry) => entry.value < 1)
        .map((entry) => entry.key)
        .toList();

    if (funcoesFaltantes.contains('heuristica')) {
      recomendacoes.add('Desenvolver habilidades de questionamento');
    }
    if (funcoesFaltantes.contains('narrativa')) {
      recomendacoes.add('Estimular a narrativa de histórias');
    }

    // Analisar compreensão verbal
    if (protocolo.compreensaoVerbal < 20) {
      recomendacoes.add('Fortalecer a compreensão de ordens simples');
    } else if (protocolo.compreensaoVerbal < 30) {
      recomendacoes.add('Desenvolver a compreensão de ordens complexas');
    }

    // Analisar desenvolvimento cognitivo
    if ((protocolo.manipulacao['exploracao_diversificada'] ?? 0) < 10) {
      recomendacoes.add('Promover a exploração diversificada de objetos');
    }
    if (protocolo.desenvolvimentoSimbolismo < 3) {
      recomendacoes.add('Estimular o brincar simbólico');
    }

    // Recomendações gerais baseadas no total
    if (totalGeral < 90) {
      recomendacoes.add('Acompanhamento fonoaudiológico regular');
      recomendacoes.add('Avaliação interdisciplinar');
    }

    return recomendacoes;
  }

  static Map<String, dynamic> gerarRelatorio(ProtocoloCompleto protocolo) {
    final resultados = calcularResultados(protocolo);
    
    return {
      'dataAvaliacao': DateTime.now().toIso8601String(),
      'pacienteId': protocolo.pacienteId,
      'resultados': resultados,
      'observacoes': protocolo.observacoes,
      'conclusoes': protocolo.conclusoes,
      'detalhamento': {
        'dialogo': protocolo.dialogo,
        'funcoes': protocolo.funcoes,
        'meiosComunicacao': protocolo.meiosComunicacao,
        'nivelContextualizacao': protocolo.nivelContextualizacao,
        'compreensaoVerbal': protocolo.compreensaoVerbal,
        'manipulacao': protocolo.manipulacao,
        'desenvolvimentoSimbolismo': protocolo.desenvolvimentoSimbolismo,
        'organizacaoBrinquedo': protocolo.organizacaoBrinquedo,
      },
    };
  }
}