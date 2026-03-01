// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ContextualizacaoWidget extends StatefulWidget {
  final int nivelContextualizacao;
  final ValueChanged<int> onChanged;

  const ContextualizacaoWidget({
    super.key,
    required this.nivelContextualizacao,
    required this.onChanged,
  });

  @override
  State<ContextualizacaoWidget> createState() => _ContextualizacaoWidgetState();
}

class _ContextualizacaoWidgetState extends State<ContextualizacaoWidget> {
  final List<Map<String, dynamic>> _opcoes = [
    {
      'valor': 5,
      'titulo': 'Nível 1',
      'descricao': 'linguagem refere-se somente à situação imediata e concreta',
    },
    {
      'valor': 10,
      'titulo': 'Nível 2',
      'descricao': 'linguagem descreve a ação que está sendo realizada e faz referências ao passado e / ou ao futuro imediato, sem ultrapassar o contexto imediato',
    },
    {
      'valor': 15,
      'titulo': 'Nível 3',
      'descricao': 'linguagem vai além da situação imediata, referindo-se a eventos mais distantes no tempo (evoca situações passadas e antecipa situações futuras não imediatas)',
    },
  ];

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
                    '1d. Níveis de contextualização da linguagem',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Selecione o nível de contextualização da linguagem',
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          ..._opcoes.map((opcao) {
            return _buildOpcaoCard(
              context,
              valor: opcao['valor'] as int,
              titulo: opcao['titulo'] as String,
              descricao: opcao['descricao'] as String,
              isSelected: widget.nivelContextualizacao == opcao['valor'],
            );
          }).toList(),
          
          const SizedBox(height: 24),
          
          // Total da seção
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pontuação máxima: 15',
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
                      '${widget.nivelContextualizacao}/15',
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

  Widget _buildOpcaoCard(
    BuildContext context, {
    required int valor,
    required String titulo,
    required String descricao,
    required bool isSelected,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isSelected ? 4 : 1,
      color: isSelected ? Theme.of(context).primaryColor.withValues(alpha: 0.1) : null,
      child: InkWell(
        onTap: () => widget.onChanged(valor),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected 
                        ? Theme.of(context).primaryColor 
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$titulo ($valor pontos)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected 
                                ? Theme.of(context).primaryColor 
                                : null,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(descricao),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}