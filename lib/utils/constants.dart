class AppConstants {
  static const List<String> escolaridades = [
    'Recém-nascido',
    'Lactente (0-12 meses)',
    '1 a 2 anos',
    'Educação Infantil',
    '1º Ano EF',
    '2º Ano EF',
    '3º Ano EF',
    '4º Ano EF',
    '5º Ano EF',
    '6º Ano EF',
    '7º Ano EF',
    '8º Ano EF',
    '9º Ano EF',
    'Ensino Médio',
    'Ensino Superior',
    'Pós-Graduação',
  ];

  static const List<String> encaminhamentos = [
    'Escola/Creche',
    'Pediatra',
    'Psicólogo',
    'Neurologista',
    'Outro profissional',
    'Família',
    'Auto-encaminhamento',
  ];

  static const Map<String, int> pontuacoesMaximas = {
    'dialogo': 16,
    'funcoes': 14,
    'meios': 15,
    'contextualizacao': 15,
    'compreensao': 40,
    'cognitivo': 50,
    'total': 150,
  };

  static String interpretarResultado(int total) {
    if (total >= 135) return 'Excelente desenvolvimento';
    if (total >= 120) return 'Bom desenvolvimento';
    if (total >= 90) return 'Desenvolvimento adequado';
    if (total >= 60) return 'Desenvolvimento aquém do esperado';
    return 'Necessita de intervenção especializada';
  }
}