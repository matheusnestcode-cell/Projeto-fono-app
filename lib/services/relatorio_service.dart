// ignore_for_file: cast_from_null_always_fails

import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
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

      return jsonData.map((data) => Relatorio.fromJson(data)).toList();
    } catch (e) {
<<<<<<< HEAD
=======
      developer.log('Erro ao listar relatórios: $e');
>>>>>>> 27342701e4b4c2d0a6ddaa8da386484f7fef3865
      return [];
    }
  }

  // Salvar novo relatório
  Future<Relatorio> salvarRelatorio(Relatorio relatorio) async {
    try {
      final relatorios = await listarRelatorios();
      relatorios.add(relatorio);

      final file = await _getRelatoriosFile();
      final jsonData = jsonEncode(relatorios.map((r) => r.toJson()).toList());

      await file.writeAsString(jsonData);
      return relatorio;
    } catch (e) {
<<<<<<< HEAD
=======
      developer.log('Erro ao salvar relatório: $e');
>>>>>>> 27342701e4b4c2d0a6ddaa8da386484f7fef3865
      rethrow;
    }
  }

  // Obter relatório por ID
  Future<Relatorio?> obterRelatorio(String id) async {
    try {
      final relatorios = await listarRelatorios();
      return relatorios.cast<Relatorio>().firstWhere((r) => r.id == id,
          orElse: () => null as Relatorio) as Relatorio?;
    } catch (e) {
<<<<<<< HEAD
=======
      developer.log('Erro ao obter relatório: $e');
>>>>>>> 27342701e4b4c2d0a6ddaa8da386484f7fef3865
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
      final jsonData = jsonEncode(relatorios.map((r) => r.toJson()).toList());

      await file.writeAsString(jsonData);
      return relatorio;
    } catch (e) {
<<<<<<< HEAD
=======
      developer.log('Erro ao atualizar relatório: $e');
>>>>>>> 27342701e4b4c2d0a6ddaa8da386484f7fef3865
      rethrow;
    }
  }

  // Deletar relatório
  Future<void> deletarRelatorio(String id) async {
    try {
      final relatorios = await listarRelatorios();
      relatorios.removeWhere((r) => r.id == id);

      final file = await _getRelatoriosFile();
      final jsonData = jsonEncode(relatorios.map((r) => r.toJson()).toList());

      await file.writeAsString(jsonData);
    } catch (e) {
<<<<<<< HEAD
=======
      developer.log('Erro ao deletar relatório: $e');
>>>>>>> 27342701e4b4c2d0a6ddaa8da386484f7fef3865
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
          .where(
              (r) => r.nomePaciente.toLowerCase().contains(nome.toLowerCase()))
          .toList();
    } catch (e) {
<<<<<<< HEAD
=======
      developer.log('Erro ao buscar relatórios: $e');
>>>>>>> 27342701e4b4c2d0a6ddaa8da386484f7fef3865
      return [];
    }
  }
}
