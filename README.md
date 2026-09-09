# DeviceSpecs

# 📱 DeviceSpecs

> **Inspecteur d'informations système pour Android & iOS, développé avec Flutter & Dart.**

DeviceSpecs est une application mobile permettant d'inspecter, visualiser et comprendre les principales caractéristiques matérielles et logicielles d'un appareil mobile.

Le projet met l'accent sur la **récupération d'informations système**, les **intégrations natives Android/iOS**, l'utilisation raisonnée de **packages open-source**, ainsi qu'une interface moderne avec des **animations fluides et une expérience utilisateur soignée**.

---

## 📑 Table des matières

* [Présentation](#-présentation)
* [Objectifs](#-objectifs)
* [Fonctionnalités](#-fonctionnalités)
* [Aperçu](#-aperçu)
* [Architecture](#-architecture)
* [Structure du projet](#-structure-du-projet)
* [Flux de données](#-flux-de-données)
* [Intégrations natives](#-intégrations-natives)
* [Packages open-source](#-packages-open-source)
* [Gestion de l'état](#-gestion-de-létat)
* [Design System](#-design-system)
* [Animations](#-animations)
* [Gestion des erreurs](#-gestion-des-erreurs)
* [Tests](#-tests)
* [Qualité du code](#-qualité-du-code)
* [Compatibilité](#-compatibilité)
* [Installation](#-installation)
* [Configuration](#-configuration)
* [Convention Git](#-convention-git)
* [Roadmap](#-roadmap)
* [Limitations](#-limitations)
* [Contribution](#-contribution)
* [Licence](#-licence)
* [Auteur](#-auteur)

---

# 📱 Présentation

DeviceSpecs est un **inspecteur système mobile** conçu pour fournir une vue claire et structurée des caractéristiques d'un appareil.

L'application permet notamment d'explorer :

* 📱 Informations générales de l'appareil
* ⚙️ Système d'exploitation
* 🧠 Processeur / CPU
* 🎮 GPU
* 💾 RAM
* 💽 Stockage
* 🔋 Batterie
* 📡 Réseau
* 🖥️ Écran
* 📳 Capteurs
* 🔧 Informations techniques supplémentaires

L'objectif n'est pas uniquement d'afficher des données, mais de construire une application Flutter capable de dialoguer efficacement avec les APIs natives des plateformes mobiles.

---


# ✨ Fonctionnalités

## 🏠 Dashboard

Le dashboard constitue le point d'entrée principal de l'application.

Il présente une synthèse des informations importantes :

* Nom de l'appareil
* Système d'exploitation
* Niveau de batterie
* RAM
* Stockage
* CPU
* Informations rapides

---

## 📱 Informations de l'appareil

Informations générales :

* Fabricant
* Modèle
* Nom de l'appareil
* Version du système
* Version SDK
* Identifiants disponibles
* Architecture processeur
* Version du firmware

---

## 🧠 CPU

Informations relatives au processeur :

* Nombre de cœurs
* Architecture CPU
* Fréquence lorsque disponible
* ABI
* Informations complémentaires fournies par la plateforme

---

## 🎮 GPU

Lorsque les informations sont accessibles :

* Nom du GPU
* Renderer
* API graphique
* Informations de rendu

---

## 💾 Mémoire RAM

Informations concernant la mémoire :

* RAM totale
* RAM disponible
* RAM utilisée
* Pourcentage d'utilisation

---

## 💽 Stockage

Informations concernant le stockage :

* Stockage total
* Espace disponible
* Espace utilisé
* Pourcentage d'utilisation

---

## 🔋 Batterie

Informations relatives à la batterie :

* Niveau de batterie
* État de charge
* Source d'alimentation
* État de la batterie lorsque disponible

---

## 🖥️ Écran

Informations concernant l'écran :

* Résolution
* Densité
* Ratio de pixels
* Taille logique
* Taille physique lorsque disponible
* Orientation

---

## 📡 Réseau

Informations disponibles concernant la connectivité :

* Wi-Fi
* Réseau mobile
* Type de connexion
* Adresse IP lorsque disponible
* État de connexion

> Certaines informations réseau peuvent être limitées par les politiques de sécurité et de confidentialité des plateformes.

---

## 📳 Capteurs

Lorsque supporté par la plateforme :

* Accéléromètre
* Gyroscope
* Magnétomètre
* Proximité
* Autres capteurs disponibles

---

# 🖼️ Aperçu

## Interface

L'interface de DeviceSpecs est basée sur la maquette fournie pour le projet.

Les principes principaux sont :

* Interface claire
* Hiérarchie visuelle forte
* Cartes d'informations
* Informations facilement scannables
* Design responsive
* Animations discrètes
* Feedback visuel lors du chargement

### Screenshots

Les captures d'écran seront ajoutées dans :

```text
docs/
└── screenshots/
    ├── dashboard.png
    ├── device-info.png
    ├── battery.png
    └── settings.png
```

---

# 🏗️ Architecture

DeviceSpecs utilise une architecture **Feature-first**, combinée à :

* MVVM
* Repository Pattern
* Service Pattern
* Domain Layer
* Dependency Injection
* Native Adapter

L'objectif est de maintenir une séparation claire entre :

```text
UI
 ↓
ViewModel
 ↓
Domain / Use Cases
 ↓
Repository
 ↓
Data Sources
 ↓
Packages / Native APIs
 ↓
Android / iOS
```

---

# 🧩 Architecture globale

```text
┌───────────────────────────────────────────────┐
│                  PRESENTATION                 │
│                                               │
│       Pages / Widgets / ViewModels            │
│                                               │
└──────────────────────┬────────────────────────┘
                       │
                       ▼
┌───────────────────────────────────────────────┐
│                    DOMAIN                     │
│                                               │
│       Entities / Use Cases / Contracts        │
│                                               │
└──────────────────────┬────────────────────────┘
                       │
                       ▼
┌───────────────────────────────────────────────┐
│                     DATA                      │
│                                               │
│       Models / Mappers / Repositories         │
│                                               │
└──────────────────────┬────────────────────────┘
                       │
              ┌────────┴────────┐
              ▼                 ▼
┌─────────────────────┐ ┌──────────────────────┐
│ Open-source         │ │ Native Integration   │
│ Packages            │ │                      │
└──────────┬──────────┘ └──────────┬───────────┘
           │                       │
           ▼                       ▼
      Dart APIs              Kotlin / Swift
                                   │
                                   ▼
                            Android / iOS APIs
```

---

# 📂 Structure du projet

```text
devicespecs/
│
├── android/
│   └── ...
│
├── ios/
│   └── ...
│
├── lib/
│   │
│   ├── main.dart
│   │
│   ├── app/
│   │   ├── app.dart
│   │   │
│   │   ├── router/
│   │   │   ├── app_router.dart
│   │   │   └── route_names.dart
│   │   │
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   ├── app_colors.dart
│   │   │   ├── app_typography.dart
│   │   │   ├── app_spacing.dart
│   │   │   └── app_radius.dart
│   │   │
│   │   └── config/
│   │       ├── app_config.dart
│   │       └── environment.dart
│   │
│   ├── core/
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── extensions/
│   │   ├── utils/
│   │   ├── result/
│   │   ├── dependency_injection/
│   │   └── widgets/
│   │
│   ├── features/
│   │   │
│   │   ├── dashboard/
│   │   │   └── presentation/
│   │   │
│   │   ├── device_info/
│   │   │   ├── domain/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │
│   │   ├── battery/
│   │   │   ├── domain/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │
│   │   ├── storage/
│   │   │   ├── domain/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │
│   │   ├── system/
│   │   │   ├── domain/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │
│   │   └── settings/
│   │       ├── domain/
│   │       ├── data/
│   │       └── presentation/
│   │
│   └── services/
│       ├── native/
│       │   ├── device_platform_service.dart
│       │   ├── battery_platform_service.dart
│       │   ├── storage_platform_service.dart
│       │   └── system_platform_service.dart
│       │
│       └── packages/
│           ├── device_info_service.dart
│           ├── battery_service.dart
│           └── storage_service.dart
│
├── test/
│   ├── core/
│   ├── features/
│   └── mocks/
│
├── integration_test/
│   ├── dashboard_test.dart
│   ├── device_info_test.dart
│   └── navigation_test.dart
│
├── assets/
│   ├── icons/
│   ├── images/
│   └── animations/
│
├── docs/
│   ├── architecture.md
│   ├── native-integration.md
│   ├── packages.md
│   ├── testing.md
│   └── screenshots/
│
├── analysis_options.yaml
├── pubspec.yaml
├── CHANGELOG.md
├── LICENSE
├── README.md
└── .gitignore
```

---

# 🔄 Flux de données

Les données suivent le chemin suivant :

```text
Operating System
       │
       ▼
Android / iOS API
       │
       ▼
Native Service
       │
       ▼
Data Source
       │
       ▼
Repository
       │
       ▼
Domain Entity
       │
       ▼
Use Case
       │
       ▼
ViewModel
       │
       ▼
Flutter UI
```

## Exemple

Pour récupérer les informations de batterie :

```text
Battery API
     ↓
BatteryPlatformService
     ↓
BatteryRepositoryImpl
     ↓
BatteryInfo
     ↓
GetBatteryInfoUseCase
     ↓
BatteryViewModel
     ↓
BatteryPage
```

---

# 🌉 Intégrations natives

L'un des objectifs majeurs du projet est de comprendre comment Flutter communique avec les plateformes natives.

## Android

Technologies utilisées :

* Kotlin
* Android SDK
* Platform APIs
* MethodChannel lorsque nécessaire

Architecture :

```text
Flutter
   │
   │ MethodChannel
   ▼
Kotlin
   │
   ▼
Android APIs
   │
   ▼
Device
```

---

## iOS

Technologies utilisées :

* Swift
* iOS SDK
* Platform APIs
* MethodChannel lorsque nécessaire

Architecture :

```text
Flutter
   │
   │ MethodChannel
   ▼
Swift
   │
   ▼
iOS APIs
   │
   ▼
Device
```

---

## Principe

Les intégrations natives ne doivent pas être directement appelées depuis les widgets Flutter.

❌ À éviter :

```dart
onPressed: () {
  const MethodChannel('device').invokeMethod('getBattery');
}
```

✅ Préférer :

```text
Widget
   ↓
ViewModel
   ↓
UseCase
   ↓
Repository
   ↓
Platform Service
   ↓
MethodChannel
```

Cette approche permet de maintenir une séparation claire des responsabilités.

---

# 📦 Packages open-source

Les packages open-source seront privilégiés lorsqu'ils permettent d'obtenir les informations nécessaires de manière fiable.

Exemples de packages pouvant être évalués :

| Package              | Utilisation                          |
| -------------------- | ------------------------------------ |
| `device_info_plus`   | Informations générales de l'appareil |
| `battery_plus`       | Informations sur la batterie         |
| `package_info_plus`  | Informations sur l'application       |
| `connectivity_plus`  | État de connectivité                 |
| `path_provider`      | Chemins système                      |
| `sensors_plus`       | Données des capteurs                 |
| `permission_handler` | Gestion des permissions              |

> Les packages définitifs seront sélectionnés après vérification de leur couverture fonctionnelle, maintenance, compatibilité Android/iOS et licence.

Chaque dépendance ajoutée doit avoir une justification technique.

---

# 🧠 Gestion de l'état

La gestion d'état doit être séparée de l'interface utilisateur.

Le ViewModel est responsable notamment de :

* Charger les données
* Exposer l'état
* Gérer les erreurs
* Déclencher les actualisations
* Coordonner les Use Cases

Exemple conceptuel :

```dart
class DeviceInfoViewModel {
  final GetDeviceInfoUseCase getDeviceInfo;

  DeviceInfoViewModel({
    required this.getDeviceInfo,
  });

  Future<void> loadDeviceInfo() async {
    // récupération des données
  }
}
```

Le widget ne doit pas contenir la logique de récupération des données système.

---

# 🎨 Design System

Le design de DeviceSpecs doit être centralisé afin d'éviter les valeurs dispersées dans les widgets.

## Couleurs

```text
AppColors
├── primary
├── secondary
├── background
├── surface
├── textPrimary
├── textSecondary
├── success
├── warning
└── error
```

---

## Typographie

```text
AppTypography
├── display
├── heading
├── title
├── body
├── label
└── caption
```

---

## Espacements

Les espacements doivent être standardisés :

```text
AppSpacing
├── xs
├── sm
├── md
├── lg
├── xl
└── xxl
```

---

## Composants réutilisables

Les composants communs doivent être placés dans :

```text
core/widgets/
```

Exemples :

```text
AppCard
AppSection
LoadingView
ErrorView
AnimatedNumber
```

---

# ✨ Animations

Les animations constituent une fonctionnalité bonus du projet.

Elles doivent améliorer l'expérience utilisateur sans rendre l'interface excessive.

Animations envisagées :

* Apparition progressive des cartes
* Animation des valeurs numériques
* Progression RAM / stockage
* Animation du niveau de batterie
* Transitions entre pages
* Micro-interactions
* Loading states
* Refresh animation

Exemple conceptuel :

```text
Dashboard
     │
     ├── Card 1 → Fade + Slide
     ├── Card 2 → Fade + Slide
     ├── Card 3 → Fade + Slide
     └── Card 4 → Fade + Slide
```

### Principe

> **Animation = information + feedback, pas décoration.**

Les animations doivent rester fluides et ne pas dégrader les performances.

---

# ⚠️ Gestion des erreurs

DeviceSpecs doit considérer qu'une information système peut être :

* indisponible
* non supportée
* limitée par la plateforme
* refusée par une permission
* différente entre Android et iOS

L'application ne doit donc jamais supposer qu'une information existe toujours.

Exemple :

```dart
if (value == null) {
  return 'Unavailable';
}
```

Une architecture basée sur des `Failure` permet également de distinguer :

```text
DeviceFailure
PermissionFailure
PlatformFailure
NetworkFailure
UnknownFailure
```

---

# 🧪 Tests

Le projet adopte plusieurs niveaux de tests.

## Unit Tests

Tester :

* Use Cases
* Repositories
* Mappers
* Formatters
* ViewModels

Structure :

```text
test/
└── features/
    ├── device_info/
    ├── battery/
    ├── storage/
    └── system/
```

---

## Widget Tests

Tester :

* Affichage des informations
* États de chargement
* États d'erreur
* Interactions utilisateur
* Responsive UI

---

## Integration Tests

Tester les scénarios complets :

```text
Launch application
       ↓
Dashboard
       ↓
Device information
       ↓
Battery
       ↓
Storage
       ↓
Settings
```

---

# 🧹 Qualité du code

Le projet doit respecter les principes suivants :

* Code lisible
* Responsabilités uniques
* Classes courtes
* Widgets réutilisables
* Pas de logique métier dans les widgets
* Pas de dépendances inutiles
* Analyse statique activée
* Formatage automatique
* Documentation du code complexe

Commandes principales :

```bash
flutter analyze
```

```bash
dart format .
```

```bash
flutter test
```

Tests d'intégration :

```bash
flutter test integration_test
```

---

# 📱 Compatibilité

## Android

DeviceSpecs cible les versions Android supportées par la version Flutter utilisée par le projet.

Certaines informations peuvent dépendre :

* de la version Android
* du fabricant
* du modèle
* des permissions
* des APIs disponibles

---

## iOS

Certaines informations sont également limitées par les APIs publiques d'iOS.

Le projet privilégie les APIs officiellement accessibles plutôt que les mécanismes privés.

---

# 🚀 Installation

## Prérequis

Installer :

* Flutter
* Dart
* Android Studio
* Android SDK
* Xcode pour iOS
* Git

Vérifier l'installation :

```bash
flutter doctor
```

---

## Cloner le projet

```bash
git clone <repository-url>
```

Entrer dans le projet :

```bash
cd devicespecs
```

---

## Installer les dépendances

```bash
flutter pub get
```

---

## Lancer l'application

Android :

```bash
flutter run
```

iOS :

```bash
flutter run
```

---

# ⚙️ Configuration

Les paramètres globaux de l'application sont centralisés dans :

```text
lib/app/config/
```

Exemple :

```text
app_config.dart
environment.dart
```

Aucune information sensible ne doit être commitée dans Git.

---

# 🌿 Convention Git

Le projet utilise une stratégie de branches simple.

```text
main
 │
 ├── develop
 │
 ├── feature/...
 │
 ├── fix/...
 │
 ├── refactor/...
 │
 └── chore/...
```

## Feature

```text
feature/battery-info
feature/device-dashboard
feature/native-android
```

## Fix

```text
fix/battery-percentage
fix/storage-calculation
```

## Refactor

```text
refactor/device-repository
```

---

# 📝 Convention des commits

Les commits suivent une convention inspirée de Conventional Commits.

```text
feat: add battery information
fix: correct storage calculation
refactor: improve device repository
docs: update architecture documentation
test: add battery repository tests
style: format dashboard widgets
chore: update dependencies
```

---



# ⚠️ Limitations connues

Les informations disponibles peuvent varier selon :

* Android vs iOS
* version du système
* constructeur
* modèle de l'appareil
* permissions
* APIs publiques disponibles

DeviceSpecs ne garantit donc pas que toutes les informations seront disponibles sur tous les appareils.

Lorsqu'une donnée n'est pas disponible, l'application doit afficher une valeur explicite telle que :

```text
Unavailable
Not supported
Restricted
Unknown
```

plutôt que d'afficher une valeur incorrecte.

---

# 🤝 Contribution

Les contributions sont les bienvenues.

## Processus

1. Créer une branche :

```bash
git checkout -b feature/my-feature
```

2. Développer la fonctionnalité.

3. Exécuter les vérifications :

```bash
flutter analyze
flutter test
```

4. Formater le code :

```bash
dart format .
```

5. Créer un commit :

```bash
git commit -m "feat: add my feature"
```

6. Push :

```bash
git push origin feature/my-feature
```

7. Créer une Pull Request.

---

# 📚 Documentation technique

La documentation détaillée est disponible dans :

```text
docs/
├── architecture.md
├── native-integration.md
├── packages.md
├── testing.md
└── screenshots/
```

## Architecture

```text
docs/architecture.md
```

Contient :

* Architecture globale
* Responsabilités des couches
* Flux de données
* Dependency Injection
* Patterns utilisés

## Native Integration

```text
docs/native-integration.md
```

Contient :

* Android
* Kotlin
* iOS
* Swift
* Platform Channels
* Gestion des APIs natives

## Packages

```text
docs/packages.md
```

Contient :

* Packages utilisés
* Raisons du choix
* Versions
* Alternatives étudiées
* Licences

---

# 🔐 Principes techniques

DeviceSpecs suit plusieurs principes fondamentaux.

### Single Responsibility Principle

Chaque classe possède une responsabilité claire.

### Separation of Concerns

La présentation, la logique métier et l'accès aux données sont séparés.

### Dependency Inversion

Les couches supérieures dépendent d'abstractions plutôt que d'implémentations concrètes.

### Reusability

Les composants communs sont réutilisables.

### Testability

La logique métier doit pouvoir être testée sans dépendre directement du matériel.

### Platform Awareness

Les différences Android/iOS sont isolées derrière des services appropriés.

---

# 🏆 Objectif final

DeviceSpecs n'est pas simplement une application affichant les caractéristiques d'un téléphone.

Le projet a pour objectif de démontrer la capacité à construire une application Flutter :

```text
                    DeviceSpecs
                         │
          ┌──────────────┼──────────────┐
          │              │              │
        Flutter         Dart          Native
          │              │              │
          ▼              ▼              ▼
         UI           Domain       Android/iOS
          │              │              │
          └──────────────┼──────────────┘
                         │
                         ▼
                  Clean Architecture
                         │
                         ▼
                  Production-ready
```

L'objectif est d'obtenir une application :

**🚀 Performante
🧱 Maintenable
🧪 Testable
📱 Cross-platform
🔌 Native-aware
🎨 Moderne
📚 Documentée**

---

# 📄 Licence

Ce projet est distribué sous licence :

```text
MIT License
```

Voir le fichier :

```text
LICENSE
```

---

# 👨‍💻 Auteur

**DeviceSpecs Team**

Projet développé avec :

```text
Flutter
Dart
Kotlin
Swift
Git
GitHub
```

---

## ⭐ Contribuer

Si le projet vous semble intéressant, n'hésitez pas à :

* ⭐ Star le repository
* 🐛 Signaler un bug
* 💡 Proposer une amélioration
* 🔀 Soumettre une Pull Request
* 📚 Améliorer la documentation

---

> **DeviceSpecs — Understand your device.**
