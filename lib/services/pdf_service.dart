import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/relatorio.dart';

class PDFService {
  static Future<File> gerarPDF(Relatorio relatorio) async {
    final pdf = pw.Document();

    final dateFormat = DateFormat('dd/MM/yyyy');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          // CABEÇALHO
          pw.Center(
            child: pw.Column(
              children: [
                pw.Text(
                  'RELATÓRIO DE AVALIAÇÃO FONOAUDIOLÓGICA',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
              ],
            ),
          ),

          // DADOS DO PACIENTE
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'IDENTIFICAÇÃO DO PACIENTE',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 8),
                pw.Text('Nome: ${relatorio.nomePaciente}'),
                pw.Text(
                  'Data de Nascimento: ${dateFormat.format(relatorio.dataNascimento)}',
                ),
                pw.Text(
                  'Idade: ${relatorio.idadePaciente} ${relatorio.unidadeIdade}',
                ),
                pw.Text(
                  'Data da Avaliação: ${dateFormat.format(relatorio.dataPreenchimento)}',
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          // TRIAGEM
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'TRIAGEM',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 8),
                pw.Text('Queixa Principal: ${relatorio.triagem.queixaPrincipal}'),
                pw.Text('Duração: ${relatorio.triagem.duracaoQueixa}'),
                pw.Text(
                  'Histórico do Paciente: ${relatorio.triagem.historicoPaciente}',
                ),
                pw.Text('Medicações: ${relatorio.triagem.medicacoes}'),
                pw.Text('Comorbidades: ${relatorio.triagem.comorbidades}'),
                pw.Text(
                  'Histórico Familiar: ${relatorio.triagem.historicoFamiliar}',
                ),
                pw.Text('Escolaridade: ${relatorio.triagem.escolaridade}'),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          // AVALIAÇÕES
          if (relatorio.avaliacoes.isNotEmpty)
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'AVALIAÇÕES REALIZADAS',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 8),
                  ...relatorio.avaliacoes.map((avaliacao) {
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          avaliacao.nomeAvaliacao,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          'Data: ${dateFormat.format(avaliacao.dataAvaliacao)}',
                        ),
                        if (avaliacao.pontuacao != null)
                          pw.Text(
                            'Pontuação: ${avaliacao.pontuacao}',
                          ),
                        pw.Text(
                          'Observações: ${avaliacao.observacoes}',
                        ),
                        pw.Text(
                          'Status: ${avaliacao.statusConclusao ? 'Concluído' : 'Pendente'}',
                        ),
                        pw.SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),

          pw.SizedBox(height: 20),

          // DIAGNÓSTICO
          if (relatorio.diagnostico != null)
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'DIAGNÓSTICO',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Diagnóstico: ${relatorio.diagnostico!.diagnostico}',
                  ),
                  pw.Text('CID-10: ${relatorio.diagnostico!.cid10}'),
                  pw.Text(
                    'Conduta Terapêutica: ${relatorio.diagnostico!.condutaTerapeutica}',
                  ),
                  pw.Text(
                    'Frequência de Sessões: ${relatorio.diagnostico!.frequenciaeSessoes}',
                  ),
                  pw.Text(
                    'Data de Conclusão: ${dateFormat.format(relatorio.diagnostico!.dataConclusao)}',
                  ),
                  if (relatorio.dataProximaAvaliacao != null)
                    pw.Text(
                      'Próxima Avaliação: ${dateFormat.format(relatorio.dataProximaAvaliacao!)}',
                    ),
                ],
              ),
            ),

          pw.SizedBox(height: 40),

          // RODAPÉ
          pw.Center(
            child: pw.Text(
              'Relatório gerado em ${dateFormat.format(DateTime.now())}',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );

    // Salvar PDF
    final output = await getApplicationDocumentsDirectory();
    final file = File(
      '${output.path}/Relatorio_${relatorio.nomePaciente}_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  // Compartilhar PDF
  static Future<void> compartilharPDF(File file) async {
    // Usar share_plus para compartilhar
    // await Share.shareFiles([file.path]);
  }
}
