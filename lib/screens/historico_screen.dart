import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/relatorio_provider.dart';
import '../models/relatorio.dart';
import 'package:intl/intl.dart';

class HistoricoScreen extends ConsumerWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relatoriosAsync = ref.watch(relatoriosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Avaliações'),
      ),
      body: relatoriosAsync.when(
        data: (relatorios) {
          if (relatorios.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma avaliação encontrada',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: relatorios.length,
            itemBuilder: (context, index) {
              final relatorio = relatorios[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(relatorio.nomePaciente),
                  subtitle: Text(
                    'Data: ${DateFormat('dd/MM/yyyy').format(relatorio.dataPreenchimento)}',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Navegar para detalhes do relatório
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Detalhes em desenvolvimento')),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erro ao carregar: $err')),
      ),
    );
  }
}
