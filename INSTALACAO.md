# 🚀 Guia de Instalação - Projeto Fono App

## 🏗️ Pré-requisitos

- **Flutter SDK** >= 3.13.0
- **Dart SDK** >= 3.0.0
- **Tablet ou Emulador Android**

Verifique:
```bash
flutter --version
dart --version
```

---

## 💿 Passo 1: Clonar/Atualizar o Projeto

```bash
# Se não tiver o projeto ainda
git clone https://github.com/matheusnestcode-cell/Projeto-fono-app.git
cd Projeto-fono-app

# Se já tem, atualizar
git pull origin main
```

---

## 🔗 Passo 2: Executar Correção Automática (IMPORTANTE)

### **Opção A: Linux/Mac**
```bash
bash fix_errors.sh
```

### **Opção B: Windows (PowerShell)**
```powershell
# Executar manualmente os comandos do CORRECOES.md
# OU
# Fazer as correções manualmente no VSCode
```

### **Opção C: Correção Manual (VSCode)**

1. Abra o projeto em VSCode
2. Use **Find and Replace** (Ctrl+H)
3. Siga as substituições em `CORRECOES.md`

---

## 📋 Passo 3: Limpar e Instalar Dependências

```bash
flutter clean
flutter pub get
flutter pub upgrade
```

---

## 🤍 Passo 4: Verificar Erros

```bash
flutter analyze
```

**Esperado:** Sem erros críticos

---

## 👁 Passo 5: Conectar Tablet/Emulador

### **Para Tablet Físico (Android)**
```bash
# Verificar discu conedu
adb devices

# Se não reconhecer:
# 1. Habilite USB Debug no tablet
# 2. Instale drivers ADB
# 3. Execute novamente:
adb devices
```

### **Para Emulador**
```bash
# Listar emuladores
emulator -list-avds

# Iniciar um
emulator @seu_emulador_nome

# Verificar conexão
flutter devices
```

---

## 🚀 Passo 6: Executar o App

```bash
# Modo debug (mais rápido para desenvolvimento)
flutter run

# Modo release (otimizado para tablet)
flutter run --release

# Modo verbose (para debug)
flutter run -v
```

---

## 🔉 Se Tiver Erros

### **Erro: "pubspec.yaml not found"**
```bash
cd Projeto-fono-app
ls pubspec.yaml
```

### **Erro: "Connected devices not found"**
```bash
# Linux/Mac
flutter devices

# Se nada aparecer:
adb kill-server
adb start-server
adb devices
```

### **Erro: "Package X not found"**
```bash
# Limpar tudo e reinstalar
flutter clean
flutter pub get
```

### **Erro: "SDK version mismatch"**
```bash
flutter upgrade
# ou
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer  # macOS
```

---

## 🛠️ Estrutura do Projeto

```
Projeto-fono-app/
├── lib/
│   ├── models/
│   │   └── relatorio.dart       # Modelos de dados
│   ├── services/
│   │   ├── relatorio_service.dart
│   │   └── pdf_service.dart
│   ├── providers/
│   │   └── relatorio_provider.dart
│   ├── screens/               # Telas do app
│   ├─┠ widgets/               # Componentes reutilizáveis
│   └─┠ main.dart
├─┠ pubspec.yaml            # Dependências
├─┠ CORRECOES.md            # Guia de correções
├── INSTALACAO.md           # Este arquivo
└── fix_errors.sh           # Script de auto-correção
```

---

## 🎨 Personalizando o App

### Mudar Nome da App
```bash
# Android
cd android
grep -r "applicationLabel" .
# Editar com seu nome

# iOS (se aplicavel)
cd ios
grep -r "CFBundleDisplayName" .
```

### Mudar Ícone
1. Prepare uma imagem `icon.png` (512x512)
2. Execute:
```bash
flutter pub run flutter_launcher_icons:main
```

### Mudar Splash Screen
1. Edite em `android/app/src/main/res/drawable/splash.xml`
2. Ou use: `flutter pub run flutter_native_splash:create`

---

## 👨‍💻 Desenvolvendo

### Adicionar Nova Tela
```dart
// lib/screens/nova_tela.dart
import 'package:flutter/material.dart';

class NovaTela extends StatelessWidget {
  const NovaTela({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Tela')),
      body: const Center(child: Text('Conteúdo aqui')),
    );
  }
}
```

### Usar Relatorios
```dart
final relatorios = ref.watch(relatoriosProvider);
ref.read(relatorioProvider.notifier).salvar(novoRelatorio);
```

### Gerar PDF
```dart
final file = await PDFService.gerarPDF(relatorio);
await PDFService.compartilharPDF(file);
```

---

## 📁 Salvar e Carregar Relatórios

```dart
import 'services/relatorio_service.dart';

// Salvar
final service = RelatorioService();
await service.salvarRelatorio(relatorio);

// Listar
final relatorios = await service.listarRelatorios();

// Buscar
final relatorio = await service.obterRelatorio(id);

// Atualizar
await service.atualizarRelatorio(relatorio);

// Deletar
await service.deletarRelatorio(id);
```

---

## 🚰 Hot Reload e Hot Restart

```bash
# Durante execução, digitar no terminal:
r       # Hot Reload (rápido, mantém estado)
R       # Hot Restart (completo, limpa estado)
q       # Sair
```

---

## 🕯️ Debug

```bash
# Abrir DevTools
flutter pub global activate devtools
devtools

# Com a app rodando:
flutter run
# DevTools estará em: http://localhost:9100
```

---

## 📄 Logs

```bash
# Ver logs em tempo real
flutter logs

# Filtrar por tag
flutter logs --grep "seu_termo"
```

---

## 🚀 Build e Deploy

### Build APK (para distribuição)
```bash
flutter build apk
# Saída: build/app/outputs/flutter-app.apk
```

### Build App Bundle (para Play Store)
```bash
flutter build appbundle
# Saída: build/app/outputs/bundle/release/app-release.aab
```

---

## 🆘 Pronto!

Se tudo correu bem, você deve ver:
```
🦄 Flutter Demo
😀 App rodando no seu tablet!
```

---

## 💮 Suporte

Se tiver dúvidas ou problemas:
1. Leia `CORRECOES.md`
2. Execute `flutter doctor -v` para verificar ambiente
3. Verifique logs com `flutter logs`
4. Abra issue no GitHub

---

**Sucesso! 🎉**
