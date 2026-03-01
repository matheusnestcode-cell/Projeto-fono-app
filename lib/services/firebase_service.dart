import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;
import '../models/relatorio.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ===== AUTENTICAÇÃO =====

  /// Registrar novo usuário (Terapeuta)
  Future<bool> registrar(String email, String senha, String nomeAvaliador) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Criar perfil do terapeuta no Firestore
      await _firestore.collection('terapeutas').doc(userCredential.user!.uid).set({
        'nome': nomeAvaliador,
        'email': email,
        'criadoEm': FieldValue.serverTimestamp(),
        'perfilCompleto': true,
      });

      return true;
    } catch (e) {
      developer.log('Erro ao registrar: $e');
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
      developer.log('Erro ao fazer login: $e');
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
      developer.log('Erro ao recuperar senha: $e');
      return false;
    }
  }

  /// Obter dados do perfil do terapeuta
  Future<Map<String, dynamic>?> obterPerfil() async {
    if (usuarioAtual == null) return null;
    try {
      final doc = await _firestore.collection('terapeutas').doc(usuarioAtual!.uid).get();
      return doc.data();
    } catch (e) {
      developer.log('Erro ao obter perfil: $e');
      return null;
    }
  }

  /// Atualizar perfil do terapeuta
  Future<bool> atualizarPerfil(Map<String, dynamic> dados) async {
    if (usuarioAtual == null) return false;
    try {
      await _firestore.collection('terapeutas').doc(usuarioAtual!.uid).update(dados);
      return true;
    } catch (e) {
      developer.log('Erro ao atualizar perfil: $e');
      return false;
    }
  }

  // ===== GESTÃO DE PACIENTES E RELATÓRIOS =====

  /// Salvar ou atualizar paciente e seu relatório
  Future<String?> salvarRelatorioFirebase(Relatorio relatorio) async {
    if (usuarioAtual == null) return null;
    try {
      final terapeutaId = usuarioAtual!.uid;
      
      // Referência para o paciente (usando nome como ID simples ou gerando um slug)
      // Idealmente pacientes teriam IDs únicos, mas aqui seguiremos a lógica do app
      final pacienteRef = _firestore
          .collection('terapeutas')
          .doc(terapeutaId)
          .collection('pacientes')
          .doc(relatorio.nomePaciente.replaceAll(' ', '_').toLowerCase());

      // Atualizar dados básicos do paciente
      await pacienteRef.set({
        'nome': relatorio.nomePaciente,
        'idade': relatorio.idadePaciente,
        'unidadeIdade': relatorio.unidadeIdade,
        'ultimaAvaliacao': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Salvar o relatório na subcoleção do paciente
      final docRef = await pacienteRef.collection('relatorios').add({
        ...relatorio.toJson(),
        'salvoEm': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      developer.log('Erro ao salvar relatório no Firebase: $e');
      return null;
    }
  }

  /// Obter todos os pacientes do terapeuta
  Stream<QuerySnapshot> obterPacientes() {
    if (usuarioAtual == null) return const Stream.empty();
    return _firestore
        .collection('terapeutas')
        .doc(usuarioAtual!.uid)
        .collection('pacientes')
        .orderBy('ultimaAvaliacao', descending: true)
        .snapshots();
  }

  /// Obter relatórios de um paciente específico
  Stream<QuerySnapshot> obterRelatoriosPaciente(String pacienteId) {
    if (usuarioAtual == null) return const Stream.empty();
    return _firestore
        .collection('terapeutas')
        .doc(usuarioAtual!.uid)
        .collection('pacientes')
        .doc(pacienteId)
        .collection('relatorios')
        .orderBy('dataPreenchimento', descending: true)
        .snapshots();
  }
}
