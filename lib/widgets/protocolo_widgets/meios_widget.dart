import 'package:flutter/material.dart';

class MeiosWidget extends StatefulWidget {
  final int meiosComunicacao;
  final ValueChanged<int> onChanged;

  const MeiosWidget({
    super.key,
    required this.meiosComunicacao,
    required this.onChanged,
  });

  @override
  State<MeiosWidget> createState() => _MeiosWidgetState();
}

class _MeiosWidgetState extends State<MeiosWidget> {
  final List<Map<String, dynamic>> _opcoesSemOralidade = [
    {'valor': 1, 'descricao': 'somente gestos não simbólicos elementares (pegar na mão e levar, puxar, cutucar)'},
    {'valor': 2, 'descricao': 'gestos não simbólicos convencionais (apontar, negar com a cabeça, gesto de vem cá)'},
    {'valor': 3, 'descricao': 'gestos simbólicos (gestos que representam ações, objetos, idade)'},
    {'valor': 4, 'descricao': 'somente vocalizações não articuladas'},
    {'valor': 5, 'descricao': 'vocalizações não articuladas e articuladas com entonação da língua (jargão)'},
  ];

  final List<Map<String, dynamic>> _opcoesComOralidade = [
    {'valor': 7, 'descricao': 'palavras isoladas contextuais (ligadas ao contexto imediato)'},
    {'valor': 9, 'descricao': 'palavras isoladas referenciais (não ligadas ao contexto imediato)'},
    {'valor': 11, 'descricao': 'frases "telegráficas" com 3 ou mais palavras de categorias diferentes'},
    {'valor': 13, 'descricao': 'relato de experiências imediatas com frases com 5/6 palavras sem omissões de elementos ("o que você está fazendo? Eu estou ...")'},
    {'valor': 15, 'descricao': 'relato verbal de experiências não imediatas ("o que aconteceu na escola? Teve um dia ...")'},
  ];

  bool _comOralidade = true;

  @override
  Widget build(BuildContext context) {
    final opcoes = _comOralidade ? _opcoesComOralidade : _opcoesSemOralidade;
    final maxPontos = _comOralidade ? 15 : 5;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1c. Meios de comunicação',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Verificar se os meios atingiram níveis de simbolização',
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'A criança possui oralidade?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _comOralidade = true;
                              widget.onChanged(0);
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: _comOralidade
                                ? Theme.of(context).primaryColor.withOpacity(0.1)
                                : null,
                            side: BorderSide(
                              color: _comOralidade
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: const Text('Com oralidade'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _comOralidade = false;
                              widget.onChanged(0);
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: !_comOralidade
                                ? Theme.of(context).primaryColor.withOpacity(0.1)
                                : null,
                            side: BorderSide(
                              color: !_comOralidade
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: const Text('Sem oralidade'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          ...opcoes.map((opcao) {
            return _buildOpcaoCard(
              context,
              valor: opcao['valor'] as int,
              descricao: opcao['descricao'] as String,
              isSelected: widget.meiosComunicacao == opcao['valor'],
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
                    'Pontuação máxima: $maxPontos',
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
                      '${widget.meiosComunicacao}/$maxPontos',
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
      color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
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
                child: Text(
                  '$valor - $descricao',
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}