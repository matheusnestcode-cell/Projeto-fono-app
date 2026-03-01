// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ResultadosScreen extends StatelessWidget {
  final String nomePaciente;
  final String idadePaciente;
  final String unidadeIdade;
  final String escolaridade;
  final String motivo;
  final int totalDialogo;
  final int totalFuncoes;
  final int meiosComunicacao;
  final int nivelContextualizacao;
  final int compreensaoVerbal;
  final int manipulacao;
  final int desenvolvimentoSimbolismo;
  final int organizacaoBrinquedo;
  final int totalHabilidades;
  final int totalCognitivo;
  final int totalGeral;
  final Map<String, int> dialogo;
  final Map<String, int> funcoes;

  const ResultadosScreen({
    super.key,
    required this.nomePaciente,
    required this.idadePaciente,
    required this.unidadeIdade,
    required this.escolaridade,
    required this.motivo,
    required this.totalDialogo,
    required this.totalFuncoes,
    required this.meiosComunicacao,
    required this.nivelContextualizacao,
    required this.compreensaoVerbal,
    required this.manipulacao,
    required this.desenvolvimentoSimbolismo,
    required this.organizacaoBrinquedo,
    required this.totalHabilidades,
    required this.totalCognitivo,
    required this.totalGeral,
    required this.dialogo,
    required this.funcoes,
  });

  String _getInterpretacao(int total) {
    if (total >= 135) return 'EXCELENTE DESENVOLVIMENTO';
    if (total >= 120) return 'BOM DESENVOLVIMENTO';
    if (total >= 90) return 'DESENVOLVIMENTO ADEQUADO';
    if (total >= 60) return 'DESENVOLVIMENTO AQUÉM DO ESPERADO';
    return 'NECESSITA DE INTERVENÇÃO ESPECIALIZADA';
  }

  Color _getCorResultado(int total) {
    if (total >= 135) return Colors.green;
    if (total >= 120) return Colors.blue;
    if (total >= 90) return Colors.orange;
    if (total >= 60) return Colors.orange.shade800;
    return Colors.red;
  }

  Future<void> _gerarPdf(BuildContext context) async {
    try {
      // Mostrar indicador de carregamento
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gerando PDF...'),
          duration: Duration(seconds: 2),
        ),
      );

      // Criar PDF
      final pdf = pw.Document();

      // Adicionar página
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Cabeçalho
                  pw.Header(
                    level: 0,
                    child: pw.Text(
                      'PROTOCOLO DE AVALIAÇÃO FONOAUDIOLÓGICA',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Resultados da Avaliação',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),

                  // Dados do Paciente
                  pw.Container(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.blue50,
                      borderRadius: pw.BorderRadius.all(pw.Radius.circular(5)),
                    ),
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Paciente: $nomePaciente',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text('Idade: $idadePaciente $unidadeIdade'),
                        pw.Text(
                            'Data: ${DateTime.now().toLocal().toString().split(' ')[0]}'),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 20),

                  // Resultado Geral
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey100,
                      border: pw.Border.all(color: PdfColors.black, width: 1),
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(5)),
                    ),
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Column(
                      children: [
                        pw.Text(
                          'RESULTADO GERAL',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          '$totalGeral / 150',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                            color: _getCorPdf(totalGeral),
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          _getInterpretacao(totalGeral),
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: _getCorPdf(totalGeral),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 20),

                  // Tabela de Resultados
                  pw.Text(
                    'Resultados Detalhados',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),

                  pw.Table.fromTextArray(
                    border:
                        pw.TableBorder.all(color: PdfColors.black, width: 0.5),
                    cellAlignment: pw.Alignment.center,
                    headerDecoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    headerHeight: 25,
                    cellHeight: 30,
                    cellAlignments: {
                      0: pw.Alignment.centerLeft,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                    },
                    headers: ['Seção', 'Pontuação', 'Máximo', '%'],
                    data: [
                      [
                        '1a. Habilidades Dialógicas',
                        '$totalDialogo',
                        '16',
                        '${(totalDialogo / 16 * 100).toInt()}%'
                      ],
                      [
                        '1b. Funções Comunicativas',
                        '$totalFuncoes',
                        '14',
                        '${(totalFuncoes / 14 * 100).toInt()}%'
                      ],
                      [
                        '1c. Meios de Comunicação',
                        '$meiosComunicacao',
                        '15',
                        '${(meiosComunicacao / 15 * 100).toInt()}%'
                      ],
                      [
                        '1d. Contextualização',
                        '$nivelContextualizacao',
                        '15',
                        '${(nivelContextualizacao / 15 * 100).toInt()}%'
                      ],
                      [
                        'TOTAL COMUNICAÇÃO',
                        '$totalHabilidades',
                        '60',
                        '${(totalHabilidades / 60 * 100).toInt()}%'
                      ],
                      [
                        '2. Compreensão Verbal',
                        '$compreensaoVerbal',
                        '40',
                        '${(compreensaoVerbal / 40 * 100).toInt()}%'
                      ],
                      [
                        '3a. Manipulação',
                        '$manipulacao',
                        '20',
                        '${(manipulacao / 20 * 100).toInt()}%'
                      ],
                      [
                        '3b. Simbolismo',
                        '$desenvolvimentoSimbolismo',
                        '20',
                        '${(desenvolvimentoSimbolismo / 20 * 100).toInt()}%'
                      ],
                      [
                        '3c. Organização',
                        '$organizacaoBrinquedo',
                        '15',
                        '${(organizacaoBrinquedo / 15 * 100).toInt()}%'
                      ],
                      [
                        'TOTAL COGNITIVO',
                        '$totalCognitivo',
                        '50',
                        '${(totalCognitivo / 50 * 100).toInt()}%'
                      ],
                    ],
                  ),
                  pw.SizedBox(height: 20),

                  // Gráficos em barras
                  pw.Text(
                    'Progresso por Seção',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  
                  _buildPdfProgressBar(
                      'Comunicação', totalHabilidades, 60, PdfColors.blue),
                  pw.SizedBox(height: 8),
                  _buildPdfProgressBar(
                      'Compreensão', compreensaoVerbal, 40, PdfColors.green),
                  pw.SizedBox(height: 8),
                  _buildPdfProgressBar(
                      'Cognição', totalCognitivo, 50, PdfColors.orange),
                  pw.SizedBox(height: 8),
                  _buildPdfProgressBar(
                      'TOTAL', totalGeral, 150, _getCorPdf(totalGeral)),
                  pw.SizedBox(height: 20),

                  // Observações
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey),
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(5)),
                    ),
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Observações:',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          '• Data de emissão: ${DateTime.now().toLocal()}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ];
          },
        ),
      );

      // Salvar PDF em arquivo temporário
      final output = await getTemporaryDirectory();
      final fileName =
          'Avaliação_${nomePaciente.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${output.path}/$fileName');
      await file.writeAsBytes(await pdf.save());

      // Compartilhar o PDF
      await Share.shareFiles(
        [file.path],
        subject: 'Resultados da Avaliação - $nomePaciente',
        text:
            'Segue em anexo os resultados da avaliação fonoaudiológica de $nomePaciente.',
        mimeTypes: ['application/pdf'],
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao gerar PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Função auxiliar para converter cor do Flutter para cor do PDF
  PdfColor _getCorPdf(int total) {
    if (total >= 135) return PdfColors.green;
    if (total >= 120) return PdfColors.blue;
    if (total >= 90) return PdfColors.orange;
    if (total >= 60) return PdfColors.orange;
    return PdfColors.red;
  }

  // Widget para criar barras de progresso no PDF
  pw.Widget _buildPdfProgressBar(
      String label, int valor, int maximo, PdfColor color) {
    final percentual = valor / maximo;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              label,
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.Text(
              '${(percentual * 100).toInt()}% ($valor/$maximo)',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ],
        ),
        pw.SizedBox(height: 2),
        pw.Container(
          height: 8,
          width: double.infinity,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Stack(
            children: [
              pw.Container(
                width: double.infinity,
                decoration: const pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
                ),
              ),
              pw.Container(
                width: percentual * PdfPageFormat.a4.width - 40,
                decoration: pw.BoxDecoration(
                  color: color,
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(4)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final interpretacao = _getInterpretacao(totalGeral);
    final corResultado = _getCorResultado(totalGeral);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados da Avaliação'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _gerarPdf(context),
            tooltip: 'Gerar e Compartilhar PDF',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _gerarPdf(context),
            tooltip: 'Compartilhar Resultados',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nomePaciente,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Idade: $idadePaciente $unidadeIdade'),
                    Text('Escolaridade: $escolaridade'),
                    Text('Motivo: $motivo'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Resultado Geral
            Card(
              color: corResultado.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'TOTAL GERAL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$totalGeral/150',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: corResultado,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      interpretacao,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: corResultado,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tabela de Resultados
            const Text(
              'Resultados Detalhados',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Seção',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Pontuação',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Máximo',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('%',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('1a. Habilidades Dialógicas')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$totalDialogo')),
                    const Padding(
                        padding: EdgeInsets.all(8), child: Text('16')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('${(totalDialogo / 16 * 100).toInt()}%')),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('1b. Funções Comunicativas')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$totalFuncoes')),
                    const Padding(
                        padding: EdgeInsets.all(8), child: Text('14')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('${(totalFuncoes / 14 * 100).toInt()}%')),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('1c. Meios de Comunicação')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$meiosComunicacao')),
                    const Padding(
                        padding: EdgeInsets.all(8), child: Text('15')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child:
                            Text('${(meiosComunicacao / 15 * 100).toInt()}%')),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('1d. Contextualização')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$nivelContextualizacao')),
                    const Padding(
                        padding: EdgeInsets.all(8), child: Text('15')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                            '${(nivelContextualizacao / 15 * 100).toInt()}%')),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(color: Colors.blue.shade50),
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('TOTAL COMUNICAÇÃO',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$totalHabilidades',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('60',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('${(totalHabilidades / 60 * 100).toInt()}%',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 241, 28, 13)),
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('2. Compreensão Verbal')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$compreensaoVerbal')),
                    const Padding(
                        padding: EdgeInsets.all(8), child: Text('40')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child:
                            Text('${(compreensaoVerbal / 40 * 100).toInt()}%')),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('3a. Manipulação')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$manipulacao')),
                    const Padding(
                        padding: EdgeInsets.all(8), child: Text('20')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('${(manipulacao / 20 * 100).toInt()}%')),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('3b. Simbolismo')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$desenvolvimentoSimbolismo')),
                    const Padding(
                        padding: EdgeInsets.all(8), child: Text('20')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                            '${(desenvolvimentoSimbolismo / 20 * 100).toInt()}%')),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('3c. Organização')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$organizacaoBrinquedo')),
                    const Padding(
                        padding: EdgeInsets.all(8), child: Text('15')),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                            '${(organizacaoBrinquedo / 15 * 100).toInt()}%')),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(color: Colors.green.shade50),
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('TOTAL COGNIÇÃO',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('$totalCognitivo',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('50',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('${(totalCognitivo / 50 * 100).toInt()}%',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Gráficos Simples
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Progresso por Seção',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildProgressBar(
                        'Comunicação', totalHabilidades, 60, Colors.blue),
                    const SizedBox(height: 12),
                    _buildProgressBar(
                        'Compreensão', compreensaoVerbal, 40, Colors.green),
                    const SizedBox(height: 12),
                    _buildProgressBar(
                        'Cognição', totalCognitivo, 50, Colors.orange),
                    const SizedBox(height: 12),
                    _buildProgressBar('TOTAL', totalGeral, 150, corResultado),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Botões de Ação
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _gerarPdf(context),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('GERAR PDF'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('INÍCIO'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, int valor, int maximo, Color color) {
    final percentual = valor / maximo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text('${(percentual * 100).toInt()}% ($valor/$maximo)'),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentual,
          backgroundColor: Colors.grey.shade200,
          color: color,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}
