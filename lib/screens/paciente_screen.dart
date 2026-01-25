import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_fono/screens/protocolo_screen.dart';
import 'package:protocolo_fono/utils/constants.dart';

class PacienteScreen extends StatefulWidget {
  const PacienteScreen({super.key});

  @override
  State<PacienteScreen> createState() => _PacienteScreenState();
}

class _PacienteScreenState extends State<PacienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _escolaController = TextEditingController();
  final _encaminhamentoController = TextEditingController();
  final _motivoController = TextEditingController();
  final _contatoController = TextEditingController();
  final _observacoesController = TextEditingController();

  DateTime? _dataNascimento;
  String? _escolaridade;
  String? _encaminhamento;
  
  // Nova variável para idade
  final TextEditingController _idadeController = TextEditingController();
  String _unidadeIdade = 'anos'; // 'anos' ou 'meses'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Paciente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo*',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              InkWell(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _dataNascimento = selectedDate;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dataNascimento != null
                            ? DateFormat('dd/MM/yyyy').format(_dataNascimento!)
                            : 'Selecione a data',
                        style: TextStyle(
                          color: _dataNascimento != null 
                              ? Colors.black 
                              : Colors.grey,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de idade com seleção de unidade
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _idadeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Idade*',
                        prefixIcon: Icon(Icons.cake),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, informe a idade';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Idade inválida';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      initialValue: _unidadeIdade,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'meses',
                          child: Text('meses'),
                        ),
                        DropdownMenuItem(
                          value: 'anos',
                          child: Text('anos'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _unidadeIdade = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _escolaridade,
                decoration: const InputDecoration(
                  labelText: 'Escolaridade',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                items: AppConstants.escolaridades
                    .map((escolaridade) => DropdownMenuItem(
                          value: escolaridade,
                          child: Text(escolaridade),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _escolaridade = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _escolaController,
                decoration: const InputDecoration(
                  labelText: 'Escola/Creche',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _encaminhamento,
                decoration: const InputDecoration(
                  labelText: 'Encaminhamento',
                  prefixIcon: Icon(Icons.assignment_turned_in),
                  border: OutlineInputBorder(),
                ),
                items: AppConstants.encaminhamentos
                    .map((encaminhamento) => DropdownMenuItem(
                          value: encaminhamento,
                          child: Text(encaminhamento),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _encaminhamento = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _motivoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Motivo do Encaminhamento*',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o motivo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _contatoController,
                decoration: const InputDecoration(
                  labelText: 'Contato (telefone/email)',
                  prefixIcon: Icon(Icons.contact_phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _observacoesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Observações',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvarEContinuar,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'SALVAR E INICIAR PROTOCOLO',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _salvarEContinuar() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProtocoloScreen(
            nomePaciente: _nomeController.text,
            idadePaciente: _idadeController.text,
            unidadeIdade: _unidadeIdade,
            escolaridade: _escolaridade ?? '',
            motivo: _motivoController.text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _escolaController.dispose();
    _encaminhamentoController.dispose();
    _motivoController.dispose();
    _contatoController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }
}