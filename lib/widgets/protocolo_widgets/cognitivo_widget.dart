import 'package:flutter/material.dart';

class CognitivoWidget extends StatefulWidget {
  final Map<String, int> manipulacao;
  final int desenvolvimentoSimbolismo;
  final int organizacaoBrinquedo;
  final ValueChanged<Map<String, int>> onManipulacaoChanged;
  final ValueChanged<int> onSimbolismoChanged;
  final ValueChanged<int> onOrganizacaoChanged;

  const CognitivoWidget({
    super.key,
    required this.manipulacao,
    required this.desenvolvimentoSimbolismo,
    required this.organizacaoBrinquedo,
    required this.onManipulacaoChanged,
    required this.onSimbolismoChanged,
    required this.onOrganizacaoChanged,
  });

  @override
  State<CognitivoWidget> createState() => _CognitivoWidgetState();
}

class _CognitivoWidgetState extends State<CognitivoWidget> {
  final Map<String, List<String>> _opcoesManipulacao = {
    'interesse_objetos': ['Não se interessa pelos objetos [0]', 'Se interessa pelos objetos [1]'],
    'desiste_atividade': ['Desiste da atividade quando surge algum obstáculo [0]', 'Persiste na atividade [1]'],
    'atuacao_repetitiva': ['Atua sobre os objetos de modo repetitivo ou estereotipado [1]', 'Não atua de modo repetitivo [0]'],
    'exploracao_objetos': ['Explora os objetos por meio de poucas ações [1]', 'Explora os objetos de modo diversificado [2]'],
    'tempo_atencao': ['Tempo de atenção curto, explorando os objetos de modo rápido e superficial [1]', 'Tempo de atenção adequado [0]'],
    'persiste_atividade': ['Persiste na atividade quando surge algum obstáculo, tentando superá-lo [2]', 'Não persiste [0]'],
    'exploracao_diversificada': ['Explora os objetos um a um de modo diversificado [10]', 'Não explora de modo diversificado [0]'],
    'atuacao_multipla': ['Atua sobre dois ou mais objetos ao mesmo tempo relacionando-os de maneira diversificada [15]', 'Não atua sobre múltiplos objetos [0]'],
  };

  final List<Map<String, dynamic>> _opcoesSimbolismo = [
    {'valor': 0, 'descricao': 'Não apresenta condutas simbólicas, somente sensório-motoras'},
    {'valor': 1, 'descricao': 'Faz uso convencional dos objetos'},
    {'valor': 2, 'descricao': 'Apresenta esquemas simbólicos (centrados no próprio corpo)'},
    {'valor': 3, 'descricao': 'Usa bonecos ou outros parceiros no brinquedo simbólico'},
    {'valor': 4, 'descricao': 'Organiza ações simbólicas em uma seqüência'},
    {'valor': 5, 'descricao': 'Cria símbolos fazendo uso de objetos substitutos ou gestos simbólicos para representar objetos ausentes'},
    {'valor': 10, 'descricao': 'Faz uso da linguagem verbal para relatar o que está acontecendo na situação de brinquedo'},
  ];

  final List<Map<String, dynamic>> _opcoesOrganizacao = [
    {'valor': 0, 'descricao': 'manipula os objetos sem uma organização dos mesmos'},
    {'valor': 1, 'descricao': 'organiza as miniaturas em pequenos grupos, reproduzindo situações parciais, mas sem uma organização de todo o conjunto (ex: cadeiras colocadas em volta da mesa)'},
    {'valor': 1, 'descricao': 'faz pequenos agrupamentos de dois ou três objetos (ex: xícara ao lado da colher)'},
    {'valor': 2, 'descricao': 'enfileira os objetos (coloca um ao lado do outro, como se fizesse uma fila ou linha)'},
    {'valor': 3, 'descricao': 'organiza os objetos distribuindo-os de modo a configurar os diversos cômodos da casa'},
    {'valor': 4, 'descricao': 'agrupa os objetos em categorias definidas, formando classes'},
    {'valor': 4, 'descricao': 'seria os objetos de acordo com diferenças (ex.: do maior para o menor)'},
  ];

  @override
  Widget build(BuildContext context) {
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
                    '3. Aspectos do desenvolvimento cognitivo',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Avalie os aspectos cognitivos em três subseções',
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            '3a. Formas de manipulação dos objetos',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          
          ..._opcoesManipulacao.entries.map((entry) {
            final key = entry.key;
            final opcoes = entry.value;
            
            return _buildManipulacaoCard(
              context,
              descricao: _getDescricaoManipulacao(key),
              opcoes: opcoes,
              valorSelecionado: widget.manipulacao[key] ?? 0,
              onChanged: (valor) {
                final novaManipulacao = Map<String, int>.from(widget.manipulacao);
                novaManipulacao[key] = valor;
                widget.onManipulacaoChanged(novaManipulacao);
              },
            );
          }).toList(),
          
          const SizedBox(height: 24),
          
          Text(
            '3b. Nível de desenvolvimento do simbolismo',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          
          ..._opcoesSimbolismo.map((opcao) {
            return _buildSimbolismoCard(
              context,
              valor: opcao['valor'] as int,
              descricao: opcao['descricao'] as String,
              isSelected: widget.desenvolvimentoSimbolismo == opcao['valor'],
            );
          }).toList(),
          
          const SizedBox(height: 24),
          
          Text(
            '3c. Nível de organização do brinquedo',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          
          ..._opcoesOrganizacao.map((opcao) {
            return _buildOrganizacaoCard(
              context,
              valor: opcao['valor'] as int,
              descricao: opcao['descricao'] as String,
              isSelected: widget.organizacaoBrinquedo == opcao['valor'],
            );
          }).toList(),
          
          const SizedBox(height: 24),
          
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('3a. Manipulação de objetos:'),
                      Text('${widget.manipulacao.values.fold(0, (sum, value) => sum + value)}/20'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('3b. Desenvolvimento do simbolismo:'),
                      Text('${widget.desenvolvimentoSimbolismo}/20'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('3c. Organização do brinquedo:'),
                      Text('${widget.organizacaoBrinquedo}/15'),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do desenvolvimento cognitivo:',
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
                          '${widget.manipulacao.values.fold(0, (sum, value) => sum + value) + widget.desenvolvimentoSimbolismo + widget.organizacaoBrinquedo}/55',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  String _getDescricaoManipulacao(String key) {
    switch (key) {
      case 'interesse_objetos':
        return 'Interesse pelos objetos';
      case 'desiste_atividade':
        return 'Persistência na atividade';
      case 'atuacao_repetitiva':
        return 'Atuação sobre os objetos';
      case 'exploracao_objetos':
        return 'Exploração dos objetos';
      case 'tempo_atencao':
        return 'Tempo de atenção';
      case 'persiste_atividade':
        return 'Persistência diante de obstáculos';
      case 'exploracao_diversificada':
        return 'Exploração diversificada';
      case 'atuacao_multipla':
        return 'Atuação sobre múltiplos objetos';
      default:
        return '';
    }
  }

  Widget _buildManipulacaoCard(
    BuildContext context, {
    required String descricao,
    required List<String> opcoes,
    required int valorSelecionado,
    required ValueChanged<int> onChanged,
  }) {
    List<int> pontosPorOpcao = opcoes.map((opcao) {
      final regex = RegExp(r'\[(\d+)\]');
      final match = regex.firstMatch(opcao);
      return match != null ? int.parse(match.group(1)!) : 0;
    }).toList();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              descricao,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
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
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
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
                          fontSize: 12,
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

  Widget _buildSimbolismoCard(
    BuildContext context, {
    required int valor,
    required String descricao,
    required bool isSelected,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isSelected ? 2 : 1,
      color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      child: InkWell(
        onTap: () => widget.onSimbolismoChanged(valor),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
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
                        size: 12,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$valor ponto${valor > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected 
                            ? Theme.of(context).primaryColor 
                            : Colors.black,
                      ),
                    ),
                    Text(
                      descricao,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrganizacaoCard(
    BuildContext context, {
    required int valor,
    required String descricao,
    required bool isSelected,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isSelected ? 2 : 1,
      color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      child: InkWell(
        onTap: () => widget.onOrganizacaoChanged(valor),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
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
                        size: 12,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$valor ponto${valor > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected 
                            ? Theme.of(context).primaryColor 
                            : Colors.black,
                      ),
                    ),
                    Text(
                      descricao,
                      style: const TextStyle(fontSize: 12),
                    ),
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