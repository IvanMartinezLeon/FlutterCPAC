---
description: Build y deploy de proyecto Flutter a stores (Google Play + App Store)
agent: *
---

Ejecuta build de producción y deployment a Google Play y App Store.

### PRE-REQUISITOS

| Store | Requisitos |
|-------|------------|
| **Google Play** | Cuenta Developer ($25), keystore, service_account.json |
| **App Store** | Apple Developer Account, certificados, app_specific_password |

---

### FASE 1: Pre-Deploy Checklist
1. **Auditoría obligatoria (primero):**
   ```
   /auditar-flutter
   ```
   - ❌ NO continuar si hay issues críticos
   - ⚠️ Revisar DDA y ASRG compliance

2. **Verificar versiones:**
   ```
   # pubspec.yaml
   version: X.Y.Z+1  # Incrementar build number
   ```

3. **Tests passing:**
   ```
   ./scripts/run_tests.sh
   ```

4. **Analyze limpio:**
   ```
   flutter analyze && dart format .
   ```

### FASE 2: Android - Google Play
5. **Configurar signing:**
   - Verificar `android/key.properties`
   - Usar release keystore

6. **Build APK/AAB:**
   ```bash
   #AAB (Play Store requiere AAB desde 2021)
   flutter build appbundle --release

   #O APK para testing
   flutter build apk --release
   ```

7. **Subir a Play Console:**

   **Opción A: Manual**
   - Ir a [Play Console](https://play.google.com/console)
   - Crear nueva release
   - Subir `.aab`
   - Completar store listing
   - Enviar a revisión

   **Opción B: CLI (fastlane)**
   ```bash
   # Configurar Gemfile y Fastfile
   bundle exec fastlane supply --track production --release

   # O con versión específica
   bundle exec fastlane supply --track production --version_code X -- apk ./build/app/outputs/flutter-apk/app-release.apk
   ```

8. **Track de testing (primero):**
   ```
   # 1. Subir a Internal Testing
   bundle exec fastlane supply --track internal

   # 2. Esperar feedback
   # 3. Mover a Production
   bundle exec fastlane supply --track production
   ```

### FASE 3: iOS - App Store
9. **Build para distribución:**
   ```bash
   flutter build ios --release --no-codesign
   ```

10. **Abrir Xcode:**
    ```bash
    open ios/Runner.xcworkspace
    ```

11. **Configurar signing:**
    - Seleccionar Team
    - Automatic Signing
    - Elegir provisioning profile

12. **Archive + Upload:**

    **Opción A: Manual**
    - Product → Archive
    - Distribute App
    - Upload to App Store

    **Opción B: CLI (fastlane)**
    ```bash
    # Match para certificados
    bundle exec fastlane match appstore

    # Build y upload
    bundle exec fastlane build_and_upload
    ```

13. **App Store Connect:**
    - Completar metadata
    - Subir screenshots
    - Seleccionar pricing
    - Enviar a revisión

### FASE 4: Post-Deploy
14. **Verificar builds:**
    - Google Play: "Release en revisión" ✓
    - App Store: "Waiting for Review" ✓

15. **Generar Deploy Report:** `doc/reports/deploy_report_YYYY_MM_DD.md`
    ```
    # Deploy Report - YYYY-MM-DD

    ## Resumen
    - **Versión:** X.Y.Z+1
    - **Fecha:** YYYY-MM-DD
    - **Builds:** Android AAB + iOS IPA

    ## Google Play

    | Campo | Valor |
    |-------|-------|
    | Track | Production |
    | Status | En revisión / Published |
    | AAB | `build/app/outputs/bundle/release/app.aab` |

    ## App Store

    | Campo | Valor |
    |-------|-------|
    | Status | Waiting for Review |
    | Build | X |
    | Platform | iOS |

    ## Pre-Deploy Checklist

    - [x] Auditoría CPAC: Passed
    - [x] Auditoría DDA: Passed
    - [x] Auditoría ASRG: Passed
    - [x] Tests: All passed
    - [x] Analyze: 0 errors

    ## Timeline

    | Fecha | Acción |
    |-------|--------|
    | YYYY-MM-DD | Auditoría |
    | YYYY-MM-DD | Build |
    | YYYY-MM-DD | Deploy |

    ## Notas

    - ...
    ```

16. **Monitorización post-deploy:**
    - Firebase Crashlytics
    - Google Play Console → Crashes
    - App Store Connect → Crashes
    - Reviews y ratings

### FASE 5: Rollback (si falla)
17. **Google Play:**
    ```
    # Ir a Play Console
    # Production → Release → Edit Version
    # Halt Release
    # Restore Previous Version
    ```

18. **App Store:**
    - No hay rollback directo
    - Subir nueva versión con fix
    - Acelerar revisión si es crítico

### Comandos Rápidos

```bash
# 1. Pre-deploy
flutter analyze && flutter test

# 2. Build Android
flutter build appbundle --release

# 3. Build iOS
flutter build ios --release --no-codesign

# 4. Fastlane (si configurado)
bundle exec fastlane deploy
```

### Checklist de Deploy

#### Pre-Deploy
- [ ] Auditoría pasada (0 issues críticos)
- [ ] Tests: All passing
- [ ] Analyze: 0 errors
- [ ] Versión incrementada
- [ ] CHANGELOG.md actualizado
- [ ] `git tag vX.Y.Z` creado

#### Google Play
- [ ] AAB generado
- [ ] Store listing completo
- [ ] Screenshots actualizados
- [ ] Privacy Policy URL
- [ ] Submitted

#### App Store
- [ ] IPA generado
- [ ] Metadata completa
- [ ] Screenshots iPhone/iPad
- [ ] App Privacy (ATT)
- [ ] Submitted

#### Post-Deploy
- [ ] Deploy Report generado
- [ ] Log actualizado
- [ ] Monitorización activada
- [ ] Notificaciones configuradas
