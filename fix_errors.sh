#!/bin/bash

# Script de correção automática de erros no projeto Flutter
# Uso: bash fix_errors.sh

echo "🔧 Iniciando correção de erros..."
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para contar arquivos processados
count=0

echo "${YELLOW}1️⃣  Removendo imports de Firebase...${NC}"
find lib -name "*.dart" -exec sed -i '/import.*firebase_auth/d' {} +
find lib -name "*.dart" -exec sed -i '/import.*cloud_firestore/d' {} +
find lib -name "*.dart" -exec sed -i '/import.*firebase_core/d' {} +
echo "${GREEN}✅ Firebase imports removidos${NC}"
echo ""

echo "${YELLOW}2️⃣  Removendo imports de protocolo_fono...${NC}"
find lib -name "*.dart" -exec sed -i '/import.*protocolo_fono/d' {} +
echo "${GREEN}✅ protocolo_fono imports removidos${NC}"
echo ""

echo "${YELLOW}3️⃣  Corrigindo withOpacity() para withValues()...${NC}"
find lib -name "*.dart" -exec sed -i 's/\.withOpacity(\([^)]*\))/.withValues(alpha: \1)/g' {} +
echo "${GREEN}✅ withOpacity() corrigido${NC}"
echo ""

echo "${YELLOW}4️⃣  Corrigindo shareFiles() para shareXFiles()...${NC}"
# Nota: Esta é uma correção simplificada. Você pode precisar revisar manualmente
find lib -name "*.dart" -exec sed -i 's/Share\.shareFiles/Share.shareXFiles/g' {} +
echo "${GREEN}✅ shareFiles() corrigido (REVISE MANUALMENTE)${NC}"
echo ""

echo "${YELLOW}5️⃣  Limpando pubspec.yaml...${NC}"
# Remove linhas de firebase do pubspec.yaml
sed -i '/firebase_auth/d' pubspec.yaml
sed -i '/cloud_firestore/d' pubspec.yaml
sed -i '/firebase_core/d' pubspec.yaml
echo "${GREEN}✅ pubspec.yaml limpo${NC}"
echo ""

echo "${YELLOW}6️⃣  Obtendo dependências...${NC}
flutter pub get
echo "${GREEN}✅ Dependências obtidas${NC}"
echo ""

echo "${YELLOW}7️⃣  Analisando projeto...${NC}"
flutter analyze
echo ""

echo "${GREEN}✅ CORREÇÕES CONCLUÍDAS!${NC}"
echo ""
echo "${YELLOW}⚠️  PRÓXIMAS ETAPAS:${NC}"
echo "1. Revise os arquivos em lib/ para remover referências restantes de Firebase"
echo "2. Verifique imports de 'protocolo_fono' se era um pacote local"
echo "3. Corrija manualmente shareXFiles() se necessário"
echo "4. Execute: flutter run -v"
echo ""
echo "${YELLOW}Dúvidas? Abra o arquivo CORRECOES.md${NC}"
