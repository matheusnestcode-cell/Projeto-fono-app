# Correções de Build do Android - Fono App

Este documento detalha as correções realizadas para resolver erros de compilação do Android com Firebase.

## Problemas Identificados e Resolvidos

### 1. Conflito de Versão do Kotlin
**Problema:** Erro `checkDebugDuplicateClasses` ao compilar com Firebase.
**Solução:** Atualizada a versão do Kotlin de `2.2.20` para `1.9.10` no arquivo `android/settings.gradle.kts`.

### 2. Limite de Métodos (64K Methods)
**Problema:** Firebase adiciona muitos métodos ao APK, ultrapassando o limite de 64K do Android.
**Solução:** Ativado `multiDexEnabled = true` no arquivo `android/app/build.gradle.kts` e adicionada a dependência `androidx.multidex:multidex:2.0.1`.

### 3. Versão do Android Gradle Plugin
**Problema:** Incompatibilidade entre versões do plugin e do Kotlin.
**Solução:** Atualizada a versão do Android Gradle Plugin de `8.11.1` para `8.2.0` no arquivo `android/settings.gradle.kts`.

### 4. Versão Mínima do SDK
**Problema:** Firebase exige `minSdk` de pelo menos 23 para funcionar corretamente.
**Solução:** Definido `minSdk = 23` no arquivo `android/app/build.gradle.kts`.

## Arquivos Modificados

1. **android/settings.gradle.kts**
   - Kotlin: `2.2.20` → `1.9.10`
   - Android Gradle Plugin: `8.11.1` → `8.2.0`

2. **android/app/build.gradle.kts**
   - Adicionado `multiDexEnabled = true`
   - Definido `minSdk = 23`
   - Adicionada dependência do MultiDex

## Próximos Passos

Após fazer o pull do repositório, execute:

```bash
flutter clean
flutter pub get
flutter run
```

Esses comandos garantem que o Flutter baixe as dependências corretas e compile o projeto sem erros.

## Testes Recomendados

1. **Compilação Debug:** `flutter run`
2. **Compilação Release:** `flutter run --release`
3. **Build APK:** `flutter build apk`

Se você encontrar algum erro durante a compilação, verifique se:
- O `minSdkVersion` do seu emulador/dispositivo é **23 ou superior**.
- A data e hora do seu computador estão corretas (Firebase valida certificados).
- O DNS do seu computador está configurado corretamente (8.8.8.8 é recomendado).

## Referências

- [Firebase Android Setup](https://firebase.google.com/docs/android/setup)
- [MultiDex Documentation](https://developer.android.com/studio/build/multidex)
- [Kotlin Compatibility](https://kotlinlang.org/docs/compatibility-modes.html)
