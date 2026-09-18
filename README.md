<h1 align="center">🏋️ Fitness App</h1>
<p align="center">Cross-platform fitness & nutrition app — built with Flutter, Clean Architecture, and Cubit/BLoC.</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-1F3864?style=flat" />
  <img src="https://img.shields.io/badge/State-Cubit%2FBLoC-purple?style=flat" />
  <img src="https://img.shields.io/badge/Platform-Android%20%26%20iOS-3DDC84?style=flat" />
</p>

Fitness App brings personal profiles, diet planning, meals, workouts, and progress tracking into a single mobile platform. Built as the mobile client for a backend-driven fitness system — the Flutter app renders whatever the backend returns rather than hardcoding content, with a companion [Node.js backend](https://github.com/Basit-Ali-android-Developer/fitness-backend-nodejs).

---

## 📱 Screenshots

<!--
Drag and drop your screenshots directly into this file while editing it on GitHub's
web editor — GitHub uploads them and auto-inserts the image markdown for you.
Keep all images at a consistent width (e.g. width="200") so the grid lines up evenly.
-->

<p align="center">
  <img src="screenshots/screenshot1.png" width="200" />
  <img src="screenshots/screenshot2.png" width="200" />
  <img src="screenshots/screenshot3.png" width="200" />
</p>

---

## 📱 Main Modules

| Module | What it does |
|---|---|
| 👤 **Profile** | Personal info, fitness details, account settings — synced with the backend |
| 🍎 **Diet** | Diet plans, daily nutrition info, meal schedules, calorie/nutrition targets, diet progress |
| 🍽️ **Meals** | Meal categories (breakfast/lunch/dinner/snacks), ingredients, nutrition info — dynamically fetched, not hardcoded |
| 🏋️ **Workouts** | Workout plans, exercises, sets/reps, duration, training categories, workout progress |
| 📊 **Fitness Progress** | Centralized view combining workout progress, diet adherence, and personal metrics |

## 🔐 Authentication

Login → API authentication → token → secure session → authenticated app. Credentials are attached to protected API requests, keeping auth logic out of individual screens.

---

## 🏗️ Architecture

Clean Architecture with a clear separation between presentation, domain, and data:

```
Presentation (Screens, Widgets, Cubits)
        │
        ▼
     Domain (Entities, Use Cases, Repository contracts)
        │
        ▼
      Data (Models, Repository implementations, Remote data source)
        │
        ▼
     REST API
```

**State management** uses Cubit (flutter_bloc) per feature — typical flow: `Initial → Loading → Success` or `Initial → Loading → Error`, giving predictable state handling instead of API calls living inside widgets.

**Navigation** uses GoRouter for structured, named routes, nested navigation, and authentication-based redirects:

```
Splash → Login/Auth → Home
                        ├── Diet
                        ├── Meals
                        ├── Workouts
                        └── Profile
```

**Request flow:**
```
Screen → Cubit → Use Case → Repository → Dio/HTTP → REST API → JSON → Model → Cubit → UI
```

---

## 📂 Project Structure

Feature-based organization — each module owns its own `data/`, `domain/`, and `presentation/` layers:

```
lib/
 ├─ core/
 │   ├─ routing/       # GoRouter setup
 │   ├─ network/       # Dio/HTTP client config
 │   ├─ errors/        # Error handling
 │   ├─ constants/
 │   └─ utils/
 │
 ├─ modules/
 │   ├─ authentication/
 │   ├─ profile/
 │   ├─ diet/
 │   ├─ meals/
 │   ├─ workouts/
 │   └─ home/
 │
 └─ main.dart
```

---

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Platform:** Android & iOS
- **Architecture:** Clean Architecture
- **State Management:** flutter_bloc / Cubit
- **Navigation:** GoRouter
- **Networking:** Dio, REST APIs
- **Local/Session Data:** Flutter local storage

---

## 🚀 Getting Started

```bash
git clone https://github.com/Basit-Ali-android-Developer/fitness-flutter.git
cd fitness-flutter
flutter pub get
flutter run
```

Requires the companion [fitness-backend-nodejs](https://github.com/Basit-Ali-android-Developer/fitness-backend-nodejs) running for full functionality.

---

<p align="center"><i>Built and maintained by <a href="https://github.com/Basit-Ali-android-Developer">Basit Ali</a></i></p>
