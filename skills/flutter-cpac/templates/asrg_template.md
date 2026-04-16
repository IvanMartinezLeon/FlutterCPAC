# Apple App Store Review Guidelines (ASRG) Audit Report

> **Ubicación:** `doc/reports/asrg_audit_report_YYYY_MM_DD.md`
> **Fecha de auditoría:** YYYY-MM-DD
> **URL auditada:** https://developer.apple.com/app-store/review/guidelines/

---

## Resumen Ejecutivo

| Métrica | Valor |
|---------|-------|
| Secciones auditadas | 0/6 |
| Cumplimiento total | X% |
| Issues críticos | 0 |
| Issues menores | 0 |

---

## Análisis de Secciones

| # | Sección | Descripción | Cumplimiento | Notas |
|---|---------|-------------|--------------|-------|
| 1 | 1. Safety | Contenido objetable, UGC, Kids, Daño físico | Cumple/No Cumple/N.A. | ... |
| 2 | 2. Performance | Completitud, Beta, Metadatos, Hardware | Cumple/No Cumple/N.A. | ... |
| 3 | 2.5 Software Requirements | APIs públicas, IPv6, WebKit, SiriKit | Cumple/No Cumple/N.A. | ... |
| 4 | 3. Business | Pagos, Suscripciones, Modelos negocio | Cumple/No Cumple/N.A. | ... |
| 5 | 4. Design | UI Apple, HIG compliance | Cumple/No Cumple/N.A. | ... |
| 6 | 5. Legal | Privacidad, Permisos, Términos | Cumple/No Cumple/N.A. | ... |

---

## Detalle de Hallazgos

### 🔴 Issues Críticos

| # | Sección | Guideline | Hallazgo | Recomendación |
|---|---------|-----------|---------|--------------|
| - | - | - | - | - |

### 🟡 Issues Menores

| # | Sección | Guideline | Hallazgo | Recomendación |
|---|---------|-----------|---------|--------------|
| - | - | - | - | - |

---

## Checklist de Cumplimiento

### 1. Safety
- [ ] **1.1** — Contenido objetable (defamatorio, discriminatorio, violento, pornográfico)
- [ ] **1.2** — Contenido generado por usuarios (filtros, reportes, bloqueo)
- [ ] **1.3** — Kids Category (sin enlaces externos, sin analytics de terceros)
- [ ] **1.4** — Daño físico (apps médicas, calculadoras de dosis)
- [ ] **1.5** — Información de contacto del desarrollador
- [ ] **1.6** — Medidas de seguridad de datos

### 2. Performance
- [ ] **2.1** — Completitud de app (no crashes, metadata completa)
- [ ] **2.2** — Beta testing solo en TestFlight
- [ ] **2.3** — Metadatos precisos y apropiados
- [ ] **2.4** — Compatibilidad hardware

### 2.5 Software Requirements
- [ ] **2.5.1** — APIs públicas, OS actual
- [ ] **2.5.2** — Apps auto-contenidas
- [ ] **2.5.4** — Background services solo para propósitos válidos
- [ ] **2.5.5** — Soporte IPv6
- [ ] **2.5.6** — WebKit para浏览 web
- [ ] **2.5.11** — SiriKit integration
- [ ] **2.5.12** — CallKit, SMS Fraud Extension
- [ ] **2.5.13** — Face ID con LocalAuthentication
- [ ] **2.5.14** — Consentimiento explícito para recording

### 3. Business
- [ ] **3.1.1** — In-App Purchase para contenido digital
- [ ] **3.1.2** — Suscripciones auto-renovables
- [ ] **3.2** — Publicidad apropiada

### 4. Design
- [ ] **4.1** — UI coherente con Apple platforms
- [ ] **4.2** — Navegación clara (back button, tab bar)
- [ ] **4.3** — Iconos y logos propios

### 5. Legal
- [ ] **5.1** — Privacidad (App Tracking Transparency)
- [ ] **5.1.1** — Permisos (NSUserTrackingUsageDescription, etc.)
- [ ] **5.1.2** — Datos de salud (HealthKit)
- [ ] **5.1.3** — HomeKit
- [ ] **5.1.4** — Location
- [ ] **5.1.5** — Contacts, Calendar, Reminders
- [ ] **5.1.6** — Bluetooth
- [ ] **5.1.7** — Local Network
- [ ] **5.1.8** — Media Library
- [ ] **5.1.9** — Photos
- [ ] **5.1.10** — Siri
- [ ] **5.1.11** — Touch ID / Face ID
- [ ] **5.1.12** — Apple Pay
- [ ] **5.2** — Términos de servicio

---

## Próximos Pasos

- [ ] Revisar y corregir issues críticos
- [ ] Actualizar Info.plist con permisos necesarios
- [ ] Verificar App Tracking Transparency
- [ ] Re-auditar tras cambios

---

## Metadatos

| Campo | Valor |
|-------|-------|
| Auditor | - |
| Fecha creación | YYYY-MM-DD |
| Última actualización | YYYY-MM-DD |
| iOS Version mínima | - |
| Dispositivos soportados | iPhone, iPad |
