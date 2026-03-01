// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fono_app/services/firebase_service.dart';
import '../widgets/protocolo_widgets/dialogo_widget.dart';
import '../widgets/protocolo_widgets/funcoes_widget.dart';
import '../widgets/protocolo_widgets/meios_widget.dart';
import '../widgets/protocolo_widgets/compreensao_widget.dart';
import '../widgets/protocolo_widgets/cognitivo_widget.dart';
import '../models/relatorio.dart';
import '../services/relatorio_service.dart';
import 'resultados_screen.dart';

class ProtocoloScreen extends ConsumerStatefulWidget {
  final String nomePaciente;
  final String idadePaciente;
  final String unidadeIdade;
  final String escolaridade;
  final String motivo;

  const ProtocoloScreen({
    super.key,
    required this.nomePaciente,
    required this.idadePaciente,
    required this.unidadeIdade,
    required this.escolaridade,
    required this.motivo, required DateTime dataNascimento, required DateTime dataPreenchimento,
  });

  @override
  ConsumerState<ProtocoloScreen> createState() => _ProtocoloScreenState();
}

class _ProtocoloScreenState extends ConsumerState<ProtocoloScreen> {
  int _currentStep = 0;
  final List<GlobalKey<FormState>> _formKeys = List.generate(6, (_) => GlobalKey<FormState>());

  // Seção 1: Habilidades Comunicativas
  Map<String, int> _dialogo = {
    'inicia': 0,
    'responde': 0,
    'aguarda_turno': 0,
    'participa_ativamente': 0,
  };

  Map<String, int> _funcoes = {
    'instrumental': 0,
    'protesto': 0,
    'interativa': 0,
    'nomeacao': 0,
    'informativa': 0,
    'heuristica': 0,
    'narrativa': 0,
  };

  int _meiosComunicacao = 0;
  int _nivelContextualizacao = 0;

  // Seção 2: Compreensão Verbal
  int _compreensaoVerbal = 0;

  // Seção 3: Desenvolvimento Cognitivo
  Map<String, int> _manipulacao = {
    'interesse_objetos': 0,
    'desiste_atividade': 0,
    'atuacao_repetitiva': 0,
    'exploracao_objetos': 0,
    'tempo_atencao': 0,
    'persiste_atividade': 0,
    'exploracao_diversificada': 0,
    'atuacao_multipla': 0,
  };

  int _desenvolvimentoSimbolismo = 0;
  int _organizacaoBrinquedo = 0;

  final List<String> _stepTitles = [
    '1a. Habilidades Dialógicas',
    '1b. Funções Comunicativas',
    '1c. Meios de Comunicação',
    '1d. Nível de Contextualização',
    '2. Compreensão Verbal',
    '3. Desenvolvimento Cognitivo',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Protocolo de Observação'),
            Text(
              '${widget.nomePaciente} (${widget.idadePaciente} ${widget.unidadeIdade})',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _salvarRascunho,
            tooltip: 'Salvar Rascunho',
          ),
        ],
      ),
      body: Column(
        children: [
          // Progresso
          Padding(
            padding: const EdgeInsets.all(16),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / _stepTitles.length,
              backgroundColor: Colors.grey.shade200,
              color: Theme.of(context).primaryColor,
              minHeight: 8,
            ),
          ),
          
          // Título da seção
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              _stepTitles[_currentStep],
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const Divider(),
          
          Expanded(
            child: IndexedStack(
              index: _currentStep,
              children: [
                // Página 1: Habilidades Dialógicas
                Form(
                  key: _formKeys[0],
                  child: DialogoWidget(
                    dialogo: _dialogo,
                    onChanged: (dialogo) {
                      setState(() {
                        _dialogo = dialogo;
                      });
                    },
                  ),
                ),
                
                // Página 2: Funções Comunicativas
                Form(
                  key: _formKeys[1],
                  child: FuncoesWidget(
                    funcoes: _funcoes,
                    onChanged: (funcoes) {
                      setState(() {
                        _funcoes = funcoes;
                      });
                    },
                  ),
                ),
                
                // Página 3: Meios de Comunicação
                Form(
                  key: _formKeys[2],
                  child: MeiosWidget(
                    meiosComunicacao: _meiosComunicacao,
                    onChanged: (value) {
                      setState(() {
                        _meiosComunicacao = value;
                      });
                    },
                  ),
                ),
                
                // Página 4: Nível de Contextualização
                _buildContextualizacaoPage(),
                
                // Página 5: Compreensão Verbal
                Form(
                  key: _formKeys[4],
                  child: CompreensaoWidget(
                    compreensaoVerbal: _compreensaoVerbal,
                    onChanged: (value) {
                      setState(() {
                        _compreensaoVerbal = value;
                      });
                    },
                  ),
                ),
                
                // Página 6: Desenvolvimento Cognitivo
                Form(
                  key: _formKeys[5],
                  child: CognitivoWidget(
                    manipulacao: _manipulacao,
                    desenvolvimentoSimbolismo: _desenvolvimentoSimbolismo,
                    organizacaoBrinquedo: _organizacaoBrinquedo,
                    onManipulacaoChanged: (manipulacao) {
                      setState(() {
                        _manipulacao = manipulacao;
                      });
                    },
                    onSimbolismoChanged: (value) {
                      setState(() {
                        _desenvolvimentoSimbolismo = value;
                      });
                    },
                    onOrganizacaoChanged: (value) {
                      setState(() {
                        _organizacaoBrinquedo = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Navegação
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentStep > 0 ? _anterior : null,
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text('Anterior'),
                    ],
                  ),
                ),
                
                Column(
                  children: [
                    Text(
                      '${_currentStep + 1} de ${_stepTitles.length}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${(_currentStep + 1) * 100 ~/ _stepTitles.length}% completo',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                
                ElevatedButton(
                  onPressed: _proximo,
                  child: Row(
                    children: [
                      Text(_currentStep < _stepTitles.length - 1 ? 'Próximo' : 'Finalizar'),
                      const SizedBox(width: 8),
                      Icon(_currentStep < _stepTitles.length - 1 
                          ? Icons.arrow_forward 
                          : Icons.check),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContextualizacaoPage() {
    return Form(
      key: _formKeys[3],
      child: SingleChildScrollView(
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
            
            _buildOpcaoContextualizacao(
              5,
              'Nível 1',
              'Linguagem refere-se somente à situação imediata e concreta',
            ),
            
            const SizedBox(height: 16),
            
            _buildOpcaoContextualizacao(
              10,
              'Nível 2',
              'Linguagem descreve a ação que está sendo realizada e faz referências ao passado e/ou ao futuro imediato, sem ultrapassar o contexto imediato',
            ),
            
            const SizedBox(height: 16),
            
            _buildOpcaoContextualizacao(
              15,
              'Nível 3',
              'Linguagem vai além da situação imediata, referindo-se a eventos mais distantes no tempo (evoca situações passadas e antecipa situações futuras não imediatas)',
            ),
            
            const SizedBox(height: 24),
            
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
                        '$_nivelContextualizacao/15',
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
      ),
    );
  }

  Widget _buildOpcaoContextualizacao(int valor, String titulo, String descricao) {
    final isSelected = _nivelContextualizacao == valor;
    
    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? Theme.of(context).primaryColor.withValues(alpha: 0.1) : null,
      child: InkWell(
        onTap: () {
          setState(() {
            _nivelContextualizacao = valor;
          });
        },
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected 
                            ? Theme.of(context).primaryColor 
                            : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      descricao,
                      style: const TextStyle(fontSize: 14),
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

  void _anterior() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _proximo() {
    if (_currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _finalizarProtocolo();
    }
  }

  void _salvarRascunho() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rascunho salvo com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _finalizarProtocolo() async {
    // Calcular totais
    final totalDialogo = _dialogo.values.fold(0, (sum, value) => sum + value);
    final totalFuncoes = _funcoes.values.fold(0, (sum, value) => sum + value);
    final totalHabilidades = totalDialogo + totalFuncoes + _meiosComunicacao + _nivelContextualizacao;
    final totalManipulacao = _manipulacao.values.fold(0, (sum, value) => sum + value);
    final totalCognitivo = totalManipulacao + _desenvolvimentoSimbolismo + _organizacaoBrinquedo;
    final totalGeral = totalHabilidades + _compreensaoVerbal + totalCognitivo;

    // Criar objeto Relatorio
    final relatorio = Relatorio(
      id: RelatorioService.gerarNovoId(),
      nomePaciente: widget.nomePaciente,
      idadePaciente: int.tryParse(widget.idadePaciente) ?? 0,
      unidadeIdade: widget.unidadeIdade,
      dataNascimento: DateTime.now(), // TODO: Passar data real
      dataPreenchimento: DateTime.now(),
      statusAvaliacao: 'completo',
      triagem: Triagem(
        queixaPrincipal: widget.motivo,
        duracaoQueixa: '',
        historicoPaciente: '',
        medicacoes: '',
        comorbidades: '',
        historicoFamiliar: '',
        ambienteFamily: '',
        escolaridade: widget.escolaridade,
      ),
      avaliacoes: [
        Avaliacao(
          id: '1',
          nomeAvaliacao: 'Protocolo Zorzi & Hage',
          dataAvaliacao: DateTime.now(),
          pontuacao: totalGeral.toDouble(),
          resultado: {
            'totalHabilidades': totalHabilidades,
            'totalCognitivo': totalCognitivo,
            'compreensaoVerbal': _compreensaoVerbal,
          },
          observacoes: '',
          statusConclusao: true,
        ),
      ],
    );

    // Salvar localmente
    await RelatorioService().salvarRelatorio(relatorio);

    // Salvar no Firebase
    await FirebaseService().salvarRelatorioFirebase(relatorio);

    if (!mounted) return;

    // Navegar para resultados
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultadosScreen(
          nomePaciente: widget.nomePaciente,
          idadePaciente: widget.idadePaciente,
          unidadeIdade: widget.unidadeIdade,
          escolaridade: widget.escolaridade,
          motivo: widget.motivo,
          totalDialogo: totalDialogo,
          totalFuncoes: totalFuncoes,
          meiosComunicacao: _meiosComunicacao,
          nivelContextualizacao: _nivelContextualizacao,
          compreensaoVerbal: _compreensaoVerbal,
          manipulacao: totalManipulacao,
          desenvolvimentoSimbolismo: _desenvolvimentoSimbolismo,
          organizacaoBrinquedo: _organizacaoBrinquedo,
          totalHabilidades: totalHabilidades,
          totalCognitivo: totalCognitivo,
          totalGeral: totalGeral,
          dialogo: _dialogo,
          funcoes: _funcoes,
        ),
      ),
    );
  }
}