import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'protocolo_screen.dart';

class PacienteScreen extends StatefulWidget {
  const PacienteScreen({super.key});

  @override
  State<PacienteScreen> createState() => _PacienteScreenState();
}

class _PacienteScreenState extends State<PacienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _dataPreenchimentoController = TextEditingController();

  DateTime? _dataNascimento;
  String _unidadeIdade = 'anos'; // 'anos' ou 'meses'

  @override
  void initState() {
    super.initState();
    // Preencher data de preenchimento automaticamente
    _dataPreenchimentoController.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

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
              // Nome do Paciente
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

              // Data de Nascimento (Selecionador)
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
                      _calcularIdade();
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento*',
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

              // Campo de Idade (Autopreenchido)
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _idadeController,
                      keyboardType: TextInputType.number,
                      readOnly: true, // Campo somente leitura
                      decoration: const InputDecoration(
                        labelText: 'Idade (Autopreenchido)*',
                        prefixIcon: Icon(Icons.cake),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Selecione a data de nascimento';
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

              // Data de Preenchimento (Autopreenchida)
              TextFormField(
                controller: _dataPreenchimentoController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Data de Preenchimento',
                  prefixIcon: Icon(Icons.event),
                  border: OutlineInputBorder(),
                  helperText: 'Preenchida automaticamente',
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

  /// Calcula a idade automaticamente com base na data de nascimento
  void _calcularIdade() {
    if (_dataNascimento == null) {
      _idadeController.clear();
      return;
    }

    final agora = DateTime.now();
    int anos = agora.year - _dataNascimento!.year;
    int meses = agora.month - _dataNascimento!.month;

    if (meses < 0) {
      anos--;
      meses += 12;
    }

    if (agora.day < _dataNascimento!.day && meses > 0) {
      meses--;
    }

    // Se tem menos de 2 anos, mostrar em meses
    if (anos < 2) {
      final mesesTotais = anos * 12 + meses;
      _idadeController.text = mesesTotais.toString();
      setState(() => _unidadeIdade = 'meses');
    } else {
      _idadeController.text = anos.toString();
      setState(() => _unidadeIdade = 'anos');
    }
  }

  void _salvarEContinuar() {
    if (_formKey.currentState!.validate()) {
      if (_dataNascimento == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, selecione a data de nascimento'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProtocoloScreen(
            nomePaciente: _nomeController.text,
            idadePaciente: _idadeController.text,
            unidadeIdade: _unidadeIdade,
            dataNascimento: _dataNascimento!,
            dataPreenchimento:
                DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),
            escolaridade: '',
            motivo: '',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _dataPreenchimentoController.dispose();
    super.dispose();
  }
}
