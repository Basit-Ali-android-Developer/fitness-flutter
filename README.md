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

<img width="200"  alt="Sign Up (2)" src="https://github.com/user-attachments/assets/dcf3a9a0-2690-4e1c-91b4-2f11f56c4ae8" />
<img width="200"  alt="Login (1)" src="https://github.com/user-attachments/assets/1eeafa77-e667-47cf-877d-6f8934e290e0" />
<img width="200"  alt="Complete Profile (2)" src="https://github.com/user-attachments/assets/8c561a90-453d-43ad-a8bd-265ba72bec10" />
<img width="200"  alt="Home Dashboard" src="https://github.com/user-attachments/assets/2df34f06-6d25-418f-b823-f1ebaf8fb412" />
<img width="200"  alt="Create Meal" src="https://github.com/user-attachments/assets/042a5690-b95b-47ca-8afb-edef366b28d0" />
<img width="200"  alt="Meals Home" src="https://github.com/user-attachments/assets/75f506c8-e9bb-43a6-a7af-d894cd4a097f" />
<img width="200" alt="Diet Plan Details" src="https://github.com/user-attachments/assets/2cb17957-2a3a-4aad-887d-1b094aa4ef02" />
<img width="200"  alt="Create Workout Plan" src="https://github.com/user-attachments/assets/63eb9137-3c47-483d-894f-a77d6755b841" />
<img width="200"  alt="Workout Home" src="https://github.com/user-attachments/assets/b8604613-917f-47be-9fb5-0e0aec50eb14" />
<img width="200"  alt="Profile" src="https://github.com/user-attachments/assets/b07ae7a8-ef5f-4a4c-b1e4-73f95905b513" />


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
