import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:protocolo_fono/models/relatorio.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ===== AUTENTICAÇÃO =====

  /// Registrar novo usuário
  Future<bool> registrar(String email, String senha, String nomeAvaliador) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Criar documento do usuário no Firestore
      await _firestore.collection('usuarios').doc(_auth.currentUser!.uid).set({
        'email': email,
        'nomeAvaliador': nomeAvaliador,
        'criadoEm': Timestamp.now(),
        'ativo': true,
      });

      return true;
    } catch (e) {
      print('Erro ao registrar: $e');
      return false;
    }
  }

  /// Login do usuário
  Future<bool> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return true;
    } catch (e) {
      print('Erro ao fazer login: $e');
      return false;
    }
  }

  /// Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// Obter usuário atual
  User? get usuarioAtual => _auth.currentUser;

  /// Stream de autenticação
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Recuperar senha
  Future<bool> resetarSenha(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print('Erro ao recuperar senha: $e');
      return false;
    }
  }

  /// Obter dados do avaliador
  Future<Map<String, dynamic>?> obterDadosAvaliador() async {
    if (usuarioAtual == null) return null;
    try {
      final doc = await _firestore
          .collection('usuarios')
          .doc(usuarioAtual!.uid)
          .get();
      return doc.data();
    } catch (e) {
      print('Erro ao obter dados do avaliador: $e');
      return null;
    }
  }

  // ===== RELÁTÓRIOS =====

  /// Salvar novo relatório
  Future<String?> salvarRelatorio(Relatorio relatorio) async {
    if (usuarioAtual == null) return null;
    try {
      final docRef = await _firestore
          .collection('usuarios')
          .doc(usuarioAtual!.uid)
          .collection('relatorios')
          .add(relatorio.toJson());
      return docRef.id;
    } catch (e) {
      print('Erro ao salvar relatório: $e');
      return null;
    }
  }

  /// Atualizar relatório existente
  Future<bool> atualizarRelatorio(String relatorioId, Relatorio relatorio) async {
    if (usuarioAtual == null) return false;
    try {
      await _firestore
          .collection('usuarios')
          .doc(usuarioAtual!.uid)
          .collection('relatorios')
          .doc(relatorioId)
          .update({
        ...relatorio.toJson(),
        'atualizadoEm': Timestamp.now(),
      });
      return true;
    } catch (e) {
      print('Erro ao atualizar relatório: $e');
      return false;
    }
  }

  /// Obter todos os relatórios do usuário
  Stream<List<Relatorio>> obterRelatorios() {
    if (usuarioAtual == null) return Stream.value([]);

    return _firestore
        .collection('usuarios')
        .doc(usuarioAtual!.uid)
        .collection('relatorios')
        .orderBy('criadoEm', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Relatorio.fromFirestore(doc))
            .toList());
  }

  /// Obter relatórios de um paciente específico
  Stream<List<Relatorio>> obterRelatoriosPaciente(String nomePaciente) {
    if (usuarioAtual == null) return Stream.value([]);

    return _firestore
        .collection('usuarios')
        .doc(usuarioAtual!.uid)
        .collection('relatorios')
        .where('nomePaciente', isEqualTo: nomePaciente)
        .orderBy('criadoEm', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Relatorio.fromFirestore(doc))
            .toList());
  }

  /// Obter relatório por ID
  Future<Relatorio?> obterRelatorioById(String relatorioId) async {
    if (usuarioAtual == null) return null;
    try {
      final doc = await _firestore
          .collection('usuarios')
          .doc(usuarioAtual!.uid)
          .collection('relatorios')
          .doc(relatorioId)
          .get();
      if (doc.exists) {
        return Relatorio.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Erro ao obter relatório: $e');
      return null;
    }
  }

  /// Deletar relatório
  Future<bool> deletarRelatorio(String relatorioId) async {
    if (usuarioAtual == null) return false;
    try {
      await _firestore
          .collection('usuarios')
          .doc(usuarioAtual!.uid)
          .collection('relatorios')
          .doc(relatorioId)
          .delete();
      return true;
    } catch (e) {
      print('Erro ao deletar relatório: $e');
      return false;
    }
  }

  /// Contar relatórios
  Future<int> contarRelatorios() async {
    if (usuarioAtual == null) return 0;
    try {
      final snapshot = await _firestore
          .collection('usuarios')
          .doc(usuarioAtual!.uid)
          .collection('relatorios')
          .count()
          .get();
      return snapshot.count;
    } catch (e) {
      print('Erro ao contar relatórios: $e');
      return 0;
    }
  }

  /// Buscar relatórios por data
  Future<List<Relatorio>> buscarRelatoriosPorData(
      DateTime dataInicio, DateTime dataFim) async {
    if (usuarioAtual == null) return [];
    try {
      final snapshot = await _firestore
          .collection('usuarios')
          .doc(usuarioAtual!.uid)
          .collection('relatorios')
          .where('criadoEm',
              isGreaterThanOrEqualTo: Timestamp.fromDate(dataInicio))
          .where('criadoEm', isLessThanOrEqualTo: Timestamp.fromDate(dataFim))
          .orderBy('criadoEm', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Relatorio.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Erro ao buscar relatórios por data: $e');
      return [];
    }
  }
}
