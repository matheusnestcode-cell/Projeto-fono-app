// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class DialogoWidget extends StatefulWidget {
  final Map<String, int> dialogo;
  final ValueChanged<Map<String, int>> onChanged;

  const DialogoWidget({
    super.key,
    required this.dialogo,
    required this.onChanged,
  });

  @override
  State<DialogoWidget> createState() => _DialogoWidgetState();
}

class _DialogoWidgetState extends State<DialogoWidget> {
  final Map<String, List<String>> _opcoes = {
    'inicia': ['ausente [0]', 'presente raramente [2]', 'presente frequentemente [4]'],
    'responde': ['ausente [0]', 'presente raramente [2]', 'presente frequentemente [4]'],
    'aguarda_turno': ['ausente [0]', 'presente raramente [2]', 'presente frequentemente [4]'],
    'participa_ativamente': ['ausente [0]', 'presente raramente [2]', 'presente frequentemente [4]'],
  };

  final Map<String, String> _descricoes = {
    'inicia': 'Inicia a conversação/interação',
    'responde': 'Responde ao interlocutor',
    'aguarda_turno': 'Aguarda seu turno (não se precipita, interrompendo o interlocutor)',
    'participa_ativamente': 'Participa ativamente da atividade dialógica (alternância de turnos na interação)',
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
                    '1a. Habilidades dialógicas ou conversacionais',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Verificar a participação e o grau de envolvimento da criança nos intercâmbios comunicativos',
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
              valorSelecionado: widget.dialogo[key] ?? 0,
              onChanged: (valor) {
                final novoDialogo = Map<String, int>.from(widget.dialogo);
                novoDialogo[key] = valor;
                widget.onChanged(novoDialogo);
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
                    'Total da pontuação (máximo = 16 pontos):',
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
                      '${widget.dialogo.values.fold(0, (sum, value) => sum + value)}/16',
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
    final pontosPorOpcao = [0, 2, 4];
    
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
            
            if (valorSelecionado > 0) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: valorSelecionado / 4,
                backgroundColor: Colors.grey.shade200,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}