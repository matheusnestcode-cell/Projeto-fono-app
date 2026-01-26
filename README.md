# 🗣️ Projeto Fono App

> **App de Avaliação Fonoaudiológica com Relatórios Locais e Geração de PDF**

[![Flutter](https://img.shields.io/badge/Flutter-3.13.0-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0.0-blue?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

---

## 📋 Sobre

Este projeto é um app Flutter para fonoaudiólogos criarem, gerenciarem e exportarem relatórios de avaliação fonoaudiológica.

**Características:**
- ✅ **Sem Firebase** - Tudo funciona offline
- ✅ **Sem Login** - Acesso direto aos relatórios
- ✅ **Armazenamento Local** - Dados salvos localmente em JSON
- ✅ **Geração de PDF** - Relatórios em PDF prontos para compartilhar
- ✅ **Compartilhamento** - Enviar relatórios por email/WhatsApp/etc
- ✅ **Multiplataforma** - Funciona em Tablet Android, iOS, Desktop

---

## 🚀 Quick Start

### 1. Clonar Repositório
```bash
git clone https://github.com/matheusnestcode-cell/Projeto-fono-app.git
cd Projeto-fono-app
```

### 2. Corrigir Erros de Imports
```bash
# Linux/Mac
bash fix_errors.sh

# Windows (abrir file CORRECOES.md e fazer manualmente)
```

### 3. Instalar Dependências
```bash
flutter clean
flutter pub get
```

### 4. Executar no Tablet/Emulador
```bash
flutter run
```

**Mais detalhes em `INSTALACAO.md`**

---

## 📁 Estrutura de Arquivos

```
Projeto-fono-app/
├── lib/
│   ├── models/
│   │   └── relatorio.dart              # Modelos de dados
│   ├── services/
│   │   ├── relatorio_service.dart      # CRUD de relatórios
│   │   └── pdf_service.dart            # Geração de PDF
│   ├── providers/
│   │   └── relatorio_provider.dart     # State management
│   ├── screens/                        # Telas do app
│   ├── widgets/                        # Componentes reutilizáveis
│   └── main.dart                       # Entrada da aplicação
├── pubspec.yaml                        # Dependências do projeto
├── INSTALACAO.md                       # Guia de instalação
├── CORRECOES.md                        # Guia de correções
├── fix_errors.sh                       # Script de auto-correção
└── README.md                           # Este arquivo
```

---

## 🏗️ Arquitetura

### Models (Dados)
```
Relatorio
├── Triagem (anamnese do paciente)
├── List<Avaliacao> (testes realizados)
└── Diagnostico (resultado final)
```

### Services (Lógica)
- **RelatorioService**: CRUD (Create, Read, Update, Delete) de relatórios
- **PDFService**: Geração e compartilhamento de PDFs

### Providers (State Management)
- **relatoriosProvider**: FutureProvider que lista todos os relatórios
- **relatorioProvider**: StateNotifier para gerenciar relatório atual

---

## 💾 Usando o App

### Criar Novo Relatório
```dart
import 'services/relatorio_service.dart';
import 'services/pdf_service.dart';

final service = RelatorioService();

// Criar novo relatório
final novoRelatorio = Relatorio(
  id: RelatorioService.gerarNovoId(),
  nomePaciente: 'João Silva',
  idadePaciente: 5,
  unidadeIdade: 'anos',
  dataNascimento: DateTime(2019, 3, 10),
  dataPreenchimento: DateTime.now(),
  statusAvaliacao: 'completo',
  triagem: triagem,
  avaliacoes: avaliacoes,
  diagnostico: diagnostico,
);

// Salvar
await service.salvarRelatorio(novoRelatorio);
```

### Listar Relatórios
```dart
final relatorios = await service.listarRelatorios();
for (var rel in relatorios) {
  print('${rel.nomePaciente} - ${rel.dataPreenchimento}');
}
```

### Gerar e Compartilhar PDF
```dart
// Gerar PDF
final file = await PDFService.gerarPDF(relatorio);

// Compartilhar
await PDFService.compartilharPDF(file);
```

### Buscar Relatório
```dart
final relatorio = await service.obterRelatorio(id);
```

### Atualizar Relatório
```dart
await service.atualizarRelatorio(relatorioAtualizado);
```

### Deletar Relatório
```dart
await service.deletarRelatorio(id);
```

---

## 📦 Dependências Principais

| Pacote | Versão | Uso |
|--------|--------|-----|
| `path_provider` | ^2.1.1 | Acesso ao sistema de arquivos |
| `pdf` | ^3.10.7 | Geração de PDFs |
| `printing` | ^5.11.0 | Print e preview de PDFs |
| `share_plus` | ^7.2.0 | Compartilhamento de arquivos |
| `flutter_riverpod` | ^2.5.0 | State management |
| `uuid` | ^4.0.0 | Geração de IDs únicos |
| `intl` | ^0.19.0 | Internacionalização e datas |

---

## 🐛 Corrigindo Erros Comuns

### "protocolo_fono isn't a dependency"
```bash
# Remove imports de protocolo_fono
grep -r "protocolo_fono" lib/
# Delete as linhas encontradas
```

### "Firebase isn't a dependency"
```bash
# Limpar pubspec.yaml de Firebase
sed -i '/firebase/d' pubspec.yaml
flutter pub get
```

### "withOpacity is deprecated"
```dart
// Antes
Color.black.withOpacity(0.5)

// Depois
Color.black.withValues(alpha: 0.5)
```

**Veja `CORRECOES.md` para mais detalhes**

---

## 🔧 Desenvolvimento

### Hot Reload
```bash
flutter run
# Digitar 'r' no terminal para recarregar em tempo real
```

### Debug
```bash
# Ativar DevTools
flutter pub global activate devtools
devtools

# Rodar com informações detalhadas
flutter run -v
```

### Análise de Código
```bash
flutter analyze
```

### Testes
```bash
flutter test
```

---

## 📱 Build para Produção

### Android APK
```bash
flutter build apk
# Saída: build/app/outputs/flutter-app.apk
```

### Android App Bundle
```bash
flutter build appbundle
# Saída: build/app/outputs/bundle/release/app-release.aab
```

### iOS
```bash
flutter build ios
```

---

## 📝 Formato de Dados

### Arquivo de Armazenamento
```
Android: /data/data/com.seu.app/app_flutter/relatorios.json
iOS: /Documents/relatorios.json
Desktop: ~/.fono_app/relatorios.json
```

### Estrutura JSON
```json
[
  {
    "id": "uuid-aqui",
    "nomePaciente": "João Silva",
    "idadePaciente": 5,
    "unidadeIdade": "anos",
    "dataNascimento": "2019-03-10T00:00:00.000Z",
    "dataPreenchimento": "2024-01-26T00:00:00.000Z",
    "statusAvaliacao": "completo",
    "triagem": { ... },
    "avaliacoes": [ ... ],
    "diagnostico": { ... }
  }
]
```

---

## 🌐 Multiplataforma

| Platform | Status | Testado |
|----------|--------|----------|
| Android | ✅ Completo | Sim |
| iOS | ✅ Completo | Não (precisa Mac) |
| Windows | ✅ Completo | Não |
| macOS | ✅ Completo | Não |
| Web | ⚠️ Limitado | Não |

---

## 🤝 Contribuindo

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

---

## 📄 Licença

Este projeto está sob licença MIT. Veja `LICENSE` para mais detalhes.

---

## 📧 Contato

- **GitHub**: [@matheusnestcode-cell](https://github.com/matheusnestcode-cell)
- **Email**: matheus.nestcode@gmail.com

---

## 🎯 Roadmap

- [ ] Adicionar testes unitários
- [ ] Implementar sincronização com nuvem (opcional)
- [ ] Adicionar mais tipos de avaliações
- [ ] Internacionalização (português/inglês)
- [ ] Modo escuro
- [ ] Backup automático
- [ ] Histórico de versões de relatórios

---

## 💡 Dicas de Uso

### Acessar Documentação
1. **INSTALACAO.md** - Como instalar e rodar
2. **CORRECOES.md** - Soluções para erros comuns
3. **README.md** - Este arquivo

### Primeiro Acesso
1. Execute `flutter run`
2. Crie seu primeiro relatório
3. Gere um PDF
4. Compartilhe com um colega

### Performance
- App funciona totalmente offline
- Dados armazenados localmente no dispositivo
- Sem limite de relatórios (depende do espaço)

---

## ⚠️ Problemas Conhecidos

- Compartilhamento de PDF pode não funcionar em alguns Android antigos
- Web version tem limitações de armazenamento (usar IndexedDB)

---

**Feito com ❤️ para fonoaudiólogos**
