import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:protocolo_fono/models/relatorio.dart';
import 'package:intl/intl.dart';

class PDFService {
  static Future<pw.Document> gerarPDFRelatorio(Relatorio relatorio) async {
    final pdf = pw.Document();

    final dateFormat = DateFormat('dd/MM/yyyy');
    final timeFormat = DateFormat('HH:mm');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        header: (context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            margin: const pw.EdgeInsets.only(bottom: 20),
            child: pw.Text(
              'RELATÓRIO DE AVALIAÇÃO FONOAUDIOLÓGICA',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          );
        },
        footer: (context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            margin: const pw.EdgeInsets.only(top: 20),
            child: pw.Text(
              'Página ${context.pageNumber} de ${context.pagesCount}',
              style: const pw.TextStyle(fontSize: 10),
            ),
          );
        },
        build: (context) {
          return [
            // Seção 1: Dados do Paciente
            pw.Section(
              title: 'DADOS DO PACIENTE',
              titleStyle: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Nome:', relatorio.nomePaciente),
                  _buildInfoRow(
                    'Data de Nascimento:',
                    dateFormat.format(relatorio.dataNascimento),
                  ),
                  _buildInfoRow(
                    'Idade:',
                    '${relatorio.idadePaciente} ${relatorio.unidadeIdade}',
                  ),
                  pw.SizedBox(height: 10),
                ],
              ),
            ),
            // Seção 2: Dados da Avaliação
            pw.Section(
              title: 'DADOS DA AVALIAÇÃO',
              titleStyle: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    'Avaliador:',
                    relatorio.nomeAvaliador,
                  ),
                  _buildInfoRow(
                    'Data do Preenchimento:',
                    dateFormat.format(relatorio.dataPreenchimento),
                  ),
                  _buildInfoRow(
                    'Horário:',
                    timeFormat.format(relatorio.dataPreenchimento),
                  ),
                  pw.SizedBox(height: 10),
                ],
              ),
            ),
            // Seção 3: Resultados
            pw.Section(
              title: 'RESULTADOS',
              titleStyle: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Componentes da Avaliação:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 5),
                  _buildResultRow(
                    'Total de Habilidades:',
                    relatorio.totalHabilidades.toString(),
                  ),
                  _buildResultRow(
                    'Total Cognitivo:',
                    relatorio.totalCognitivo.toString(),
                  ),
                  _buildResultRow(
                    'Compreensão Verbal:',
                    relatorio.compreensaoVerbal.toString(),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                    ),
                    child: pw.Text(
                      'Total Geral: ${relatorio.totalGeral}',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 10),
                ],
              ),
            ),
            // Seção 4: Detalhes da Avaliação
            pw.Section(
              title: 'DETALHES DA AVALIAÇÃO',
              titleStyle: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildSubsection(
                    'Diálogo',
                    relatorio.dialogo,
                  ),
                  _buildSubsection(
                    'Funções',
                    relatorio.funcoes,
                  ),
                  _buildSubsection(
                    'Manipulação',
                    relatorio.manipulacao,
                  ),
                  pw.SizedBox(height: 10),
                ],
              ),
            ),
            // Seção 5: Observações e Conclusões
            pw.Section(
              title: 'OBSERVAÇÕES E CONCLUSÕES',
              titleStyle: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (relatorio.observacoes.isNotEmpty) ...
                    [
                      pw.Text(
                        'Observações:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(relatorio.observacoes),
                      pw.SizedBox(height: 10),
                    ],
                  if (relatorio.conclusoes.isNotEmpty) ...
                    [
                      pw.Text(
                        'Conclusões:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(relatorio.conclusoes),
                    ],
                ],
              ),
            ),
          ];
        },
      ),
    );

    return pdf;
  }

  static pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
          ),
          pw.SizedBox(width: 10),
          pw.Text(
            value,
            style: const pw.TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildResultRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSubsection(
      String title, Map<String, int> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 3),
        ...items.entries.map((e) {
          return pw.Padding(
            padding: const pw.EdgeInsets.only(left: 10, bottom: 2),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  e.key,
                  style: const pw.TextStyle(fontSize: 10),
                ),
                pw.Text(
                  e.value.toString(),
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ],
            ),
          );
        }).toList(),
        pw.SizedBox(height: 5),
      ],
    );
  }
}
