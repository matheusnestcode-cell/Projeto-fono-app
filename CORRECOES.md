# 🔧 Guia de Correção de Erros

## ❌ ERROS PRINCIPAIS E SOLUÇÕES

### 1. **Pacote 'protocolo_fono' não encontrado**

**Problema:** Seu projeto faz referência a um pacote local que não existe.

**Solução:**
```bash
# Opção 1: Remover imports de protocolo_fono
# Abra todos os arquivos .dart e remova linhas como:
# import 'package:protocolo_fono/...';

# Opção 2: Se esse pacote é parte do seu projeto
# Mova os arquivos para lib/ ou crie um pacote local em:
# ./packages/protocolo_fono/
```

### 2. **Firebase não é mais dependência**

**Remova de pubspec.yaml:**
```yaml
# ❌ REMOVER:
firebase_auth: ^4.x.x
cloud_firestore: ^4.x.x
firebase_core: ^2.x.x
```

**Remova imports dos arquivos:**
```dart
// ❌ REMOVER:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
```

### 3. **Corrigir deprecated 'withOpacity()'**

**Antes:**
```dart
Color.fromARGB(255, 100, 100, 100).withOpacity(0.5)
```

**Depois:**
```dart
Color.fromARGB(255, 100, 100, 100).withValues(alpha: 0.5)
```

### 4. **Corrigir 'shareFiles()' deprecated**

**Antes:**
```dart
import 'package:share_plus/share_plus.dart';
Share.shareFiles([filePath]);
```

**Depois:**
```dart
import 'package:share_plus/share_plus.dart';
Share.shareXFiles([XFile(filePath)]);
```

### 5. **Remover print() de produção**

**Antes:**
```dart
print('Erro ao salvar: $e');
```

**Depois - Use um logger:**
```dart
import 'dart:developer' as developer;

developer.log('Erro ao salvar: $e');
// Ou em produção, registre em um serviço de logging
```

### 6. **Adicionar 'const' em construtores**

**Antes:**
```dart
Widget(
  child: Container(
    child: Text('Hello'),
  ),
)
```

**Depois:**
```dart
const Widget(
  child: SizedBox(
    child: Text('Hello'),
  ),
)
```

### 7. **Corrigir Table.fromTextArray()**

**Antes:**
```dart
import 'package:pdf/widgets.dart' as pw;
Table.fromTextArray(
  context: context,
  data: data,
)
```

**Depois:**
```dart
import 'package:pdf/widgets.dart' as pw;
pw.TableHelper.fromTextArray(
  cellHeight: 30,
  data: data,
)
```

### 8. **Corrigir BuildContext across async gaps**

**Antes:**
```dart
async Future<void> saveAndNavigate() async {
  await saveData();
  Navigator.pop(context); // ❌ Pode falhar se widget foi destruído
}
```

**Depois:**
```dart
Future<void> saveAndNavigate() async {
  if (!mounted) return; // ✅ Verificar se widget ainda existe
  await saveData();
  if (!mounted) return; // ✅ Verificar novamente antes de usar context
  Navigator.pop(context);
}
```

---

## 🚀 PASSOS DE CORREÇÃO RÁPIDA

### Passo 1: Limpar pubspec.yaml
```bash
cd seu-projeto
```

### Passo 2: Remover pacotes Firebase
```yaml
# Abra pubspec.yaml e remova:
firebase_auth
cloud_firestore
firebase_core

# Mantenha apenas:
path_provider
pdf
printing
share_plus
flutter_riverpod
riverpod_annotation
uuid
intl
```

### Passo 3: Atualizar dependências
```bash
flutter pub get
flutter pub upgrade
```

### Passo 4: Procurar e substituir em VSCode

**Abra Find and Replace (Ctrl+H):**

1. **Remover imports Firebase:**
   - Find: `import 'package:firebase_auth[^']*';`
   - Replace: (deixar em branco)
   - ✅ Replace All

2. **Remover imports protocolo_fono:**
   - Find: `import 'package:protocolo_fono[^']*';`
   - Replace: (deixar em branco)
   - ✅ Replace All

3. **Corrigir withOpacity:**
   - Find: `\.withOpacity\(([^)]*)\)`
   - Replace: `.withValues(alpha: $1)`
   - ✅ Replace All

4. **Corrigir shareFiles:**
   - Find: `Share\.shareFiles\(\[`
   - Replace: `Share.shareXFiles([XFile(`
   - ✅ Replace All (depois adicione ), manualmente ou com outra busca)

5. **Limpar print statements:**
   - Find: `print\((.*)\);`
   - Replace: `// TODO: Add logging: print($1);`
   - ✅ Replace All

### Passo 5: Verificar erros
```bash
flutter analyze
```

### Passo 6: Rodar app
```bash
flutter run
```

---

## 📝 ARQUIVOS PRINCIPAIS A VERIFICAR

Busque por references de Firebase/protocolo_fono em:

```
lib/
├── main.dart
├── screens/
│   ├── home_screen.dart
│   ├── login_screen.dart (REMOVER se tinha Firebase)
│   ├── relatorio_screen.dart
│   └── ...
├── widgets/
├── models/
├── services/
└── providers/
```

**Comando para encontrar imports Firebase:**
```bash
grep -r "firebase" lib/
grep -r "protocolo_fono" lib/
```

---

## ✅ CHECKLIST FINAL

- [ ] Removidos todos os imports de `firebase_auth`
- [ ] Removidos todos os imports de `cloud_firestore`
- [ ] Removidos todos os imports de `protocolo_fono`
- [ ] Substituído `withOpacity()` por `withValues()`
- [ ] Substituído `shareFiles()` por `shareXFiles()`
- [ ] Removido/comentado todos os `print()` de produção
- [ ] Adicionado `const` em construtores estáticos
- [ ] Verificado `BuildContext` com `if (!mounted)`
- [ ] `flutter analyze` - sem erros
- [ ] `flutter run` - app rodando no tablet

---

## 🆘 SE AINDA TIVER ERROS

1. **Limpar cache:**
```bash
flutter clean
flutter pub get
```

2. **Atualizar SDK:**
```bash
flutter upgrade
```

3. **Verificar versão do Dart:**
```bash
dart --version
# Deve estar >= 3.0
```

4. **Se persistir, compartilhe os erros específicos!**
