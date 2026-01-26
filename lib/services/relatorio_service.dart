import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../models/relatorio.dart';

class RelatorioService {
  static const String _fileName = 'relatorios.json';

  // Obter diretório de documentos
  Future<Directory> _getDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  // Obter arquivo de dados
  Future<File> _getRelatoriosFile() async {
    final dir = await _getDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  // Listar todos os relatórios
  Future<List<Relatorio>> listarRelatorios() async {
    try {
      final file = await _getRelatoriosFile();
      
      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents) as List;
      
      return jsonData
          .map((data) => Relatorio.fromJson(data))
          .toList();
    } catch (e) {
      print('Erro ao listar relatórios: $e');
      return [];
    }
  }

  // Salvar novo relatório
  Future<Relatorio> salvarRelatorio(Relatorio relatorio) async {
    try {
      final relatorios = await listarRelatorios();
      relatorios.add(relatorio);
      
      final file = await _getRelatoriosFile();
      final jsonData = jsonEncode(
        relatorios.map((r) => r.toJson()).toList()
      );
      
      await file.writeAsString(jsonData);
      return relatorio;
    } catch (e) {
      print('Erro ao salvar relatório: $e');
      rethrow;
    }
  }

  // Obter relatório por ID
  Future<Relatorio?> obterRelatorio(String id) async {
    try {
      final relatorios = await listarRelatorios();
      return relatorios.firstWhere(
        (r) => r.id == id,
        orElse: () => null as Relatorio?,
      );
    } catch (e) {
      print('Erro ao obter relatório: $e');
      return null;
    }
  }

  // Atualizar relatório
  Future<Relatorio> atualizarRelatorio(Relatorio relatorio) async {
    try {
      final relatorios = await listarRelatorios();
      final index = relatorios.indexWhere((r) => r.id == relatorio.id);
      
      if (index == -1) {
        throw Exception('Relatório não encontrado');
      }
      
      relatorios[index] = relatorio;
      
      final file = await _getRelatoriosFile();
      final jsonData = jsonEncode(
        relatorios.map((r) => r.toJson()).toList()
      );
      
      await file.writeAsString(jsonData);
      return relatorio;
    } catch (e) {
      print('Erro ao atualizar relatório: $e');
      rethrow;
    }
  }

  // Deletar relatório
  Future<void> deletarRelatorio(String id) async {
    try {
      final relatorios = await listarRelatorios();
      relatorios.removeWhere((r) => r.id == id);
      
      final file = await _getRelatoriosFile();
      final jsonData = jsonEncode(
        relatorios.map((r) => r.toJson()).toList()
      );
      
      await file.writeAsString(jsonData);
    } catch (e) {
      print('Erro ao deletar relatório: $e');
      rethrow;
    }
  }

  // Gerar novo ID
  static String gerarNovoId() {
    return const Uuid().v4();
  }

  // Buscar relatórios por nome de paciente
  Future<List<Relatorio>> buscarPorNomePaciente(String nome) async {
    try {
      final relatorios = await listarRelatorios();
      return relatorios
          .where((r) => r.nomePaciente
              .toLowerCase()
              .contains(nome.toLowerCase()))
          .toList();
    } catch (e) {
      print('Erro ao buscar relatórios: $e');
      return [];
    }
  }
}
