#===============================================================================
# FlutterCPAC - Makefile
# Atajos para comandos más frecuentes
#===============================================================================

.PHONY: help install test test-cov analyze format audit deploy migrate refactor clean

# Colores
GREEN  := \033[0;32m
YELLOW := \033[0;33m
BLUE   := \033[0;34m
NC     := \033[0m

#-------------------------------------------------------------------------------
# Help
#-------------------------------------------------------------------------------
help: ## Muestra esta ayuda
	@echo ""
	@echo "$(BLUE)╔══════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║              FlutterCPAC - Comandos Disponibles              ║$(NC)"
	@echo "$(BLUE)╚══════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""

#-------------------------------------------------------------------------------
# Instalación y Setup
#-------------------------------------------------------------------------------
install: ## Instala dependencias Flutter
	@echo "$(BLUE)📦 Instalando dependencias...$(NC)"
	flutter pub get
	@echo "$(GREEN)✓ Dependencias instaladas$(NC)"

#-------------------------------------------------------------------------------
# Análisis y Calidad
#-------------------------------------------------------------------------------
analyze: ## Ejecuta flutter analyze
	@echo "$(BLUE)🔍 Ejecutando flutter analyze...$(NC)"
	@flutter analyze

format: ## Formatea código con dart format
	@echo "$(BLUE)🎨 Formateando código...$(NC)"
	@dart format .
	@echo "$(GREEN)✓ Código formateado$(NC)"

qa: format analyze ## Formatea y analiza (combo rápido)

#-------------------------------------------------------------------------------
# Testing
#-------------------------------------------------------------------------------
test: ## Ejecuta tests
	@echo "$(BLUE)🧪 Ejecutando tests...$(NC)"
	@flutter test

test-cov: ## Ejecuta tests con cobertura
	@echo "$(BLUE)🧪 Ejecutando tests con cobertura...$(NC)"
	@flutter test --coverage
	@echo "$(GREEN)✓ Cobertura generada en coverage/$(NC)"

test-watch: ## Ejecuta tests en modo watch
	@echo "$(BLUE)👁️  Modo watch activo...$(NC)"
	@flutter test --watch

#-------------------------------------------------------------------------------
# Scripts FlutterCPAC
#-------------------------------------------------------------------------------
audit: ## Ejecuta auditoría completa CPAC
	@echo "$(BLUE)🔎 Ejecutando auditoría CPAC...$(NC)"
	@flutter analyze
	@echo "$(GREEN)✓ Auditoría completada - Ver doc/reports/audit_report_*.md$(NC)"

test-full: ## Ejecuta suite completa de tests (script)
	@echo "$(BLUE)🧪 Ejecutando suite completa de tests...$(NC)"
	@bash skills/flutter-cpac/scripts/run_tests.sh

changelog: ## Genera CHANGELOG.md desde logs
	@echo "$(BLUE)📝 Generando changelog...$(NC)"
	@bash skills/flutter-cpac/scripts/changelog.sh $(VERSION)
	@echo "$(GREEN)✓ CHANGELOG.md generado$(NC)"

#-------------------------------------------------------------------------------
# Deploy
#-------------------------------------------------------------------------------
build-apk: ## Build APK de release
	@echo "$(BLUE)📱 Build APK...$(NC)"
	@flutter build apk --release

build-aab: ## Build AAB para Play Store
	@echo "$(BLUE)📱 Build AAB...$(NC)"
	@flutter build appbundle --release

build-ios: ## Build iOS
	@echo "$(BLUE)🍎 Build iOS...$(NC)"
	@flutter build ios --release --no-codesign

build-all: build-apk build-aab build-ios ## Build todas las plataformas

deploy: ## Muestra checklist de deploy
	@echo "$(BLUE)🚀 Checklist de deploy:$(NC)"
	@echo "1. /auditar-flutter - Auditoría completa"
	@echo "2. /test-flutter - Suite de tests"
	@echo "3. make qa - flutter analyze + format"
	@echo "4. make build-aab - Generar AAB"
	@echo "5. /deploy-flutter - Subir a stores"

#-------------------------------------------------------------------------------
# Mantenimiento
#-------------------------------------------------------------------------------
migrate: ## Muestra comando de migración
	@echo "$(BLUE)🔄 Guía de migración:$(NC)"
	@echo "Usa: /migrate-flutter"

refactor: ## Muestra comando de refactor
	@echo "$(BLUE)🔧 Guía de refactor:$(NC)"
	@echo "Usa: /refactor-flutter"

clean: ## Limpia build y caches
	@echo "$(BLUE)🧹 Limpiando...$(NC)"
	@flutter clean
	@rm -rf build/ .dart_tool/ coverage/
	@echo "$(GREEN)✓ Limpieza completada$(NC)"

clean-all: clean ## Limpia todo incluyendo pub-cache
	@echo "$(BLUE)🧹 Limpiando pub-cache...$(NC)"
	@flutter pub cache clean --force
	@echo "$(GREEN)✓ pub-cache limpiado$(NC)"

#-------------------------------------------------------------------------------
# Dev
#-------------------------------------------------------------------------------
doctor: ## Verifica entorno Flutter
	@flutter doctor

run: ## Ejecuta app en debug
	@flutter run

run-ios: ## Ejecuta app en iOS simulator
	@flutter run -d iPhone

run-android: ## Ejecuta app en Android emulator
	@flutter run -d android

#-------------------------------------------------------------------------------
# Doc
#-------------------------------------------------------------------------------
doc-serve: ## Sirve documentación local
	@echo "$(BLUE)📚 Abriendo .docs/wiki...$(NC)"
	@open .docs/wiki/

#-------------------------------------------------------------------------------
# Git
#-------------------------------------------------------------------------------
commit: ## Commit con mensaje
	@git add -A && git commit -m "$(MSG)"

tag: ## Crea tag de versión
	@git tag v$(VERSION) && git push origin v$(VERSION)

#-------------------------------------------------------------------------------
# Proyecto
#-------------------------------------------------------------------------------
init: install format analyze ## Inicializa proyecto (install + format + analyze)

ci: qa test-cov ## CI pipeline completo

release: qa test-cov build-all ## Release completo (qa + test + build)

.DEFAULT_GOAL := help
