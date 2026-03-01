// Firebase foi removido - usando apenas armazenamento local
// Este arquivo é mantido para compatibilidade, mas não faz nada

import 'relatorio_service.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  final RelatorioService _relatorioService = RelatorioService();

  // Stub methods para compatibilidade com código existente
  Future<bool> registrar(String email, String senha, String nomeAvaliador) async {
    // Autenticação local não implementada
    return true;
  }

  Future<bool> login(String email, String senha) async {
    // Autenticação local não implementada
    return true;
  }

  Future<void> logout() async {
    // Logout local
  }

  Future<bool> resetarSenha(String email) async {
    // Recuperação de senha não implementada
    return false;
  }

  Future<Map<String, dynamic>?> obterDadosAvaliador() async {
    return null;
  }

  Future<String?> salvarRelatorio(dynamic relatorio) async {
    return null;
  }

  Future<bool> atualizarRelatorio(String relatorioId, dynamic relatorio) async {
    return true;
  }

  Future<bool> deletarRelatorio(String relatorioId) async {
    return true;
  }

  Future<int> contarRelatorios() async {
    return 0;
  }
}
