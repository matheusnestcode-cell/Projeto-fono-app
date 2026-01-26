import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/relatorio.dart';
import '../services/relatorio_service.dart';

final relatorioServiceProvider = Provider((ref) => RelatorioService());

final relatoriosProvider = FutureProvider<List<Relatorio>>((ref) async {
  final service = ref.watch(relatorioServiceProvider);
  return service.listarRelatorios();
});

final relatorioProvider = 
    StateNotifierProvider<RelatorioNotifier, Relatorio?>((ref) {
  return RelatorioNotifier(ref.watch(relatorioServiceProvider));
});

class RelatorioNotifier extends StateNotifier<Relatorio?> {
  final RelatorioService _service;

  RelatorioNotifier(this._service) : super(null);

  Future<void> salvar(Relatorio relatorio) async {
    await _service.salvarRelatorio(relatorio);
    state = relatorio;
  }

  Future<void> atualizar(Relatorio relatorio) async {
    await _service.atualizarRelatorio(relatorio);
    state = relatorio;
  }

  Future<void> deletar(String id) async {
    await _service.deletarRelatorio(id);
    state = null;
  }
}
