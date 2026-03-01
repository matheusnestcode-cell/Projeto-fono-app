// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CompreensaoWidget extends StatefulWidget {
  final int compreensaoVerbal;
  final ValueChanged<int> onChanged;

  const CompreensaoWidget({
    super.key,
    required this.compreensaoVerbal,
    required this.onChanged,
  });

  @override
  State<CompreensaoWidget> createState() => _CompreensaoWidgetState();
}

class _CompreensaoWidgetState extends State<CompreensaoWidget> {
  final List<Map<String, dynamic>> _opcoes = [
    {'valor': 0, 'descricao': 'Não apresenta respostas à linguagem'},
    {'valor': 10, 'descricao': 'responde assistematicamente'},
    {'valor': 15, 'descricao': 'Atende quando é chamada'},
    {'valor': 20, 'descricao': 'Compreende somente ordens com uma ação'},
    {'valor': 25, 'descricao': 'Compreende somente ordens com até duas ações'},
    {'valor': 30, 'descricao': 'Compreende ordens com 3 ou mais ações, solicitações e comentários somente quando se referem a objetos, pessoas ou situações presentes'},
    {'valor': 40, 'descricao': 'Compreende ordens com 3 ou mais ações, solicitações e comentários que se referem a objetos, pessoas ou situações ausentes'},
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
                    '2. Compreensão Verbal',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Selecione o nível de compreensão verbal da criança',
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
              descricao: opcao['descricao'] as String,
              isSelected: widget.compreensaoVerbal == opcao['valor'],
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
                    'Pontuação máxima: 40',
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
                      '${widget.compreensaoVerbal}/40',
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
    required String descricao,
    required bool isSelected,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 1,
      color: isSelected ? Theme.of(context).primaryColor.withValues(alpha: 0.1) : null,
      child: InkWell(
        onTap: () => widget.onChanged(valor),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
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
                      '$valor pontos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected 
                            ? Theme.of(context).primaryColor 
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
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