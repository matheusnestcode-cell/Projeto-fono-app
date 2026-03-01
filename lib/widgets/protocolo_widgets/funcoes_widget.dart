import 'package:flutter/material.dart';

class FuncoesWidget extends StatefulWidget {
  final Map<String, int> funcoes;
  final ValueChanged<Map<String, int>> onChanged;

  const FuncoesWidget({
    super.key,
    required this.funcoes,
    required this.onChanged,
  });

  @override
  State<FuncoesWidget> createState() => _FuncoesWidgetState();
}

class _FuncoesWidgetState extends State<FuncoesWidget> {
  final Map<String, List<String>> _opcoes = {
    'instrumental': ['ausente [0]', 'presente raramente [1]', 'presente frequentemente [2]'],
    'protesto': ['ausente [0]', 'presente raramente [1]', 'presente frequentemente [2]'],
    'interativa': ['ausente [0]', 'presente raramente [1]', 'presente frequentemente [2]'],
    'nomeacao': ['ausente [0]', 'presente raramente [1]', 'presente frequentemente [2]'],
    'informativa': ['ausente [0]', 'presente raramente [1]', 'presente frequentemente [2]'],
    'heuristica': ['ausente [0]', 'presente raramente [1]', 'presente frequentemente [2]'],
    'narrativa': ['ausente [0]', 'presente raramente [1]', 'presente frequentemente [2]'],
  };

  final Map<String, String> _descricoes = {
    'instrumental': 'Instrumental - solicitação de objetos, ações ("dar um brinquedo; abrir uma porta")',
    'protesto': 'Protesto – interrupção com fala ou ação uma ação indesejada ("pára")',
    'interativa': 'Interativa – uso de expressões sociais para iniciar ou encerrar a interação ("oi, tchau")',
    'nomeacao': 'Nomeação – nomeação espontânea de objetos, pessoas ações ("ó cachorro")',
    'informativa': 'Informativa – comentários, informações espontâneas na interação ("ó meu sapato")',
    'heuristica': 'Heurística – solicitação de informação ou permissão ("pode pegar? / Cadê a bola?")',
    'narrativa': 'Narrativa – presença de turnos narrativos ("o príncipe beijou a princesa e casou")',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1b. Funções comunicativas',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Avalie as funções comunicativas da criança',
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          ..._opcoes.entries.map((entry) {
            final key = entry.key;
            final opcoes = entry.value;
            
            return _buildQuestionCard(
              context,
              descricao: _descricoes[key]!,
              opcoes: opcoes,
              valorSelecionado: widget.funcoes[key] ?? 0,
              onChanged: (valor) {
                final novasFuncoes = Map<String, int>.from(widget.funcoes);
                novasFuncoes[key] = valor;
                widget.onChanged(novasFuncoes);
              },
            );
          }).toList(),
          
          const SizedBox(height: 24),
          
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total da pontuação (máximo = 14 pontos):',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.funcoes.values.fold(0, (sum, value) => sum + value)}/14',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(
    BuildContext context, {
    required String descricao,
    required List<String> opcoes,
    required int valorSelecionado,
    required ValueChanged<int> onChanged,
  }) {
    final pontosPorOpcao = [0, 1, 2];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              descricao,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: List.generate(opcoes.length, (index) {
                final texto = opcoes[index];
                final pontos = pontosPorOpcao[index];
                
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      onPressed: () => onChanged(pontos),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: valorSelecionado == pontos
                            ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                            : null,
                        side: BorderSide(
                          color: valorSelecionado == pontos
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        texto,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: valorSelecionado == pontos
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                          fontWeight: valorSelecionado == pontos
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}